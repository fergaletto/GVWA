function [J,MSE] = GAVWAType2GPU(I,G,SigmaS,scale,Niter)

%input: I -- image to be processing I \in [0,1]
%       G -- guidance image G \in [0,1]
%       SigmaS -- bilateral spacial parameter, large ->larger scale object
%       smoothed out
%       scale -- bilateral range parameter, scale<1 -> sharper results

padMethod = 'symmetric';%used by MATLAB "imguidedfilter"
patchSize = floor(4*SigmaS) + 1;
if mod(patchSize,2) == 0
   patchSize = patchSize + 1; %must be odd number
end
patchSize = max(3,patchSize); %must be at least 3

N = patchSize*patchSize;
hs = ones(patchSize)/N;


muG = (imfilter(G, hs,padMethod));%patch mean of I
muGG = (imfilter(G.*G, hs,padMethod));%patch mean of G
w = max(0,muGG - muG.*muG);
if size(G,3) > 1
    w = max(w,[],3);
end

SigmaR = scale*mean(w(:));
w = w./SigmaR;
w = 1./(1+w.^2); %or w = exp(-(w).^2)+0.0001;

ha = fspecial('gaussian',patchSize,SigmaS);
normalizeFactor = imfilter(w,ha,padMethod);
if size(I,3) > 1
    w = cat(3,w,w,w); %make it 3d
    normalizeFactor = cat(3,normalizeFactor,normalizeFactor,normalizeFactor);
end
%J = I;
MSE = zeros(Niter,1);
J = gpuArray(I);
w = gpuArray(w);
normalizeFactor = gpuArray(normalizeFactor);
for n = 1 : Niter
    J = imfilter(w.*J,ha,padMethod)./(eps+normalizeFactor) ;   
    %MSE(n) = mean((J(:)-I(:)).^2);
end
J = gather(J);
end

