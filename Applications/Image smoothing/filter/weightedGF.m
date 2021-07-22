function J = weightedGF(I,G,patchSize,Epsilon, MODE)

%input: I -- image to be processing I \in [0,1]
%       G -- guidance image G \in [0,1]
%       patchSize --must be odd integer
%       Epsilon -- smaller less smoothing usually < 1

padMethod = 'symmetric';%used by MATLAB "imguidedfilter"
muI = imboxfilt(I, patchSize,'Padding',padMethod);%patch mean of I
muG = imboxfilt(G, patchSize,'Padding',padMethod);%patch mean of G
covIG = imboxfilt(I.*G, patchSize,'Padding',padMethod) - muI.*muG; %patch mean of I*G
varG = imboxfilt(G.*G, patchSize,'Padding',padMethod) - muG.*muG;

%calculate a
%a = mean((I-muI)*(G-muG))/(var(G)+Epsilon)
%  = (mean(I*G) - muI*muG)/(var(G) + Epsilon)
%  = covIG./(var(G) + Epsilon)
a = covIG./(varG + Epsilon);
%calculate b: b = muI - a.*muG
b = muI - a.*muG;

switch MODE
    case 1
        disp('variance weighted average TIP2020')
        %IEEE TRANSACTIONS ON IMAGE PROCESSING, VOL. 29, 2020 1397
        %Anisotropic Guided Filtering
        %Carlo Noel Ochotorena and Yukihiko Yamashita
        
        alpha = 2; %set it to > 1 to show the result
        w = 1./(varG.^alpha + 1e-10);
        a = imboxfilt(w.*a,patchSize,'Padding',padMethod);
        b = imboxfilt(w.*b,patchSize,'Padding',padMethod);
        normalizeFactor = imboxfilt(w,patchSize,'Padding',padMethod);
        J = (a.*G + b)./normalizeFactor;
    case 2
        disp('patch model MSE weighted average SVIP 2019')
        %Weighted aggregation for guided image filtering,
        %Bin Chen, Shiqian Wu
        %SIVP, 2019
        eta = 0.004; % Small number >0
        varI = imboxfilt(I.^2,patchSize,'Padding',padMethod) - muI.^2;
        e = a.^2.*varG - 2*a.*covIG + varI; % MSE
        w = exp(-e./eta);
        a = imboxfilt(w.*a,patchSize,'Padding',padMethod);
        b = imboxfilt(w.*b,patchSize,'Padding',padMethod);
        normalizeFactor = imboxfilt(w,patchSize,'Padding',padMethod);
        J = (a.*G + b)./normalizeFactor;
    case 3
        %disp('adative regularization TIP2015')
        %Z. Li, J. Zheng, Z. Zhu, W. Yao, and S. Wu, "Weighted guided image
        %filtering," IEEE Trans. Image Process., vol. 24, no. 1, pp. 120-129,
        %Jan. 2015.
        
        %does the patch size make a difference? I am not sure.
        %3x3 patch size
        %muG2 = imboxfilt(G,[3,3],'Padding','symmetric');
        %varG2 = imboxfilt(G.^2,[3,3],'Padding','symmetric') - muG2.^2;
        
        %same patch size as everything else
        varG2 = imboxfilt(G.^2,patchSize,'Padding',padMethod) - muG.^2;
        varG2 = max(0,varG2);
        w = (varG2+1e-10).*imboxfilt(1./(varG2+1e-10),patchSize,'Padding',padMethod);
        a = covIG./(varG + Epsilon./w);
        b = muI - a.*muG;
        a = imboxfilt(a,patchSize,'Padding',padMethod);
        b = imboxfilt(b,patchSize,'Padding',padMethod);
        J = a.*G + b;
    case 4
        disp('Select a and b by using median')
        winSize = 7;
        a = medianFilter(a,winSize);
        b = medianFilter(b,winSize);
        J = a.*G + b;
    case 5
        disp('EGIF Average of local variances')
        % IEEE SIGNAL PROCESSING LETTERS, VOL. 25, NO. 10, OCTOBER 20181585
        % Effective Guided Image Filtering forContrast Enhancement
        % Zongwei Lu, Bangyuan Long, Kang Li and Fajin Lu
        
        w = ones(size(G)).*mean(mean(varG,2), 1);% Average of local variances.
        a = covIG./(varG + Epsilon.*w);
        b = muI - a.*muG;
        a = imboxfilt(a,patchSize,'Padding',padMethod);
        b = imboxfilt(b,patchSize,'Padding',padMethod);
        J = a.*G + b;
        
    case 6
       % disp('combine adative regularization TIP2015 with variance weighted average TIP2020')
        %adaptie regulalrization
        w = (varG+1e-10).*imboxfilt(1./(varG+1e-10),patchSize,'Padding',padMethod);
        a = covIG./(varG + Epsilon./w);
        b = muI - a.*muG;
        %variance based weighted average
        alpha = 4; %set it to > 1 to show the result
        w = 1./(varG.^alpha + 1e-10);
        a = imboxfilt(w.*a,patchSize,'Padding',padMethod);
        b = imboxfilt(w.*b,patchSize,'Padding',padMethod);
        normalizeFactor = imboxfilt(w,patchSize,'Padding',padMethod);
        J = (a.*G + b)./normalizeFactor;
    case 7
        disp('The gradient domain guided filter')
        eps0 = 1e-5;
        w1    = (varG+eps0).*imboxfilt(1./(varG+eps0),patchSize,'Padding',padMethod); %equ.9
        minVarG  = min(varG(:));
        meanVarG = mean(varG(:));
        kk = 4/(meanVarG - minVarG);
        w = 1 - 1./(1+exp(kk*(varG - meanVarG)));             %equ.11
        a = (covIG +Epsilon*w./w1) ./ (varG + Epsilon./w1);   %equ.12
        b = muI - a .* muG;                                       %equ.13

        a = imboxfilt(a,patchSize,'Padding',padMethod);
        b = imboxfilt(b,patchSize,'Padding',padMethod);
        J = a.*G + b;
    case 8
        disp('GAIF -- to be published IET IP')
        %this is a combination of the 2015 TIP paper idea
        %for weighted average with the GAIF
        %
        MODEL = 2; %select which one to use
        if MODEL == 1 %the absolute difference case
            %Epsilon = Epsilon/patchSize*patchSize;
            MAE = imboxfilt(abs(I-G),patchSize,'Padding',padMethod); 
            a = min(1,MAE/2/Epsilon);
            b = (1-a).*G;
        else
            %Epsilon = Epsilon/patchSize*patchSize;
            MSE = imboxfilt((I-G).^2,patchSize,'Padding',padMethod); 
            a = MSE./(MSE + Epsilon);
            b = (1-a).*G;
        end
        varI = imboxfilt(I.^2,patchSize,'Padding',padMethod) - muI.^2;
        varI = max(0,varI);
        w = 1./(varI+1e-6);
        normalizeFactor = imboxfilt(w,patchSize,'Padding',padMethod);
        a = imboxfilt(w.*a,patchSize,'Padding',padMethod)./normalizeFactor;
        b = imboxfilt(w.*b,patchSize,'Padding',padMethod);
        J = (a.*I + b)./normalizeFactor;% same as a.*I + (1-a).*G).*G
    case 9
        disp('My case')
        sigma = 1
        alpha = 2
        vl = locallapfilt(I,sigma,alpha)
        mul = imboxfilt(vl,patchSize,'Padding',padMethod);
        w = imboxfilt(vl.^2,patchSize,'Padding',padMethod) - mul.^2;
        alpha = 2; %set it to > 1 to show the result
        %w = 1./(varG.^alpha + 1e-10);
        a = imboxfilt(w.*a,patchSize,'Padding',padMethod);
        b = imboxfilt(w.*b,patchSize,'Padding',padMethod);
        normalizeFactor = imboxfilt(w,patchSize,'Padding',padMethod);
        J = (a.*G + b)./normalizeFactor;
    otherwise
        disp('Original GF')
        %average
        %original GF just average
        a = imboxfilt(a,patchSize,'Padding',padMethod);
        b = imboxfilt(b,patchSize,'Padding',padMethod);
        J = a.*G + b;
end

end

