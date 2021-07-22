function [J,w] = GAVWAe4(I,G,SigmaS,SigmaR)

%input: I -- image to be processing I \in [0,1]
%       G -- guidance image G \in [0,1]
%       SigmaS -- bilateral spacial parameter, large ->larger scale object
%       smoothed out
%       SigmaR -- bilateral range parameter, Small-> sharper results

padMethod = 'symmetric';%used by MATLAB "imguidedfilter"
patchSize = floor(4*SigmaS) + 1;
if mod(patchSize,2) == 0
   patchSize = patchSize + 1;
end

N = patchSize*patchSize;
hs = ones(patchSize)/N;

muG = (imfilter(G, hs,padMethod));%patch mean of I
muGG = (imfilter(G.*G, hs,padMethod));%patch mean of G
w = max(max(0,muGG - muG.*muG),[],3);

SigmaR = 2*SigmaR*SigmaR;
w = w./SigmaR;
w = 1./(1+w.^2); %or w = exp(-(w).^2)+0.0001;

ha = fspecial('gaussian',patchSize,SigmaS);
normalizeFactor = imfilter(w,ha,padMethod);
w = cat(3,w,w,w); %make it 3d
normalizeFactor = cat(3,normalizeFactor,normalizeFactor,normalizeFactor);
J = imfilter(w.*I,ha,padMethod)./(eps+normalizeFactor) ;         
end
