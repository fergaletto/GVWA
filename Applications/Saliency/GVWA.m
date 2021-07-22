function [J,w] = GVWA(I,G,SigmaS,scale,Lambda)

%input: I -- image to be processing I \in [0,1]
%       G -- guidance image G \in [0,1]
%       patchSize --must be odd integer
%       Sigma -- bilateral parameter, Sigma -> large ->AVMA
%       Lambda -- adaptive weight

padMethod = 'symmetric';
patchSize = floor(4*SigmaS) + 1;
if mod(patchSize,2) == 0
   patchSize = patchSize + 1;
end

patchSize = min(3,patchSize);
%square kernel
N = patchSize*patchSize;
hs = ones(patchSize)/N;

muG = (imfilter(G, hs,padMethod));%patch mean of I
muGG = (imfilter(G.*G, hs,padMethod));%patch mean of G


w = max(max(0,muGG - muG.*muG),[],3);
w = w./(scale*mean(w(:)));
w = 1./(1+w.^2); 


ha = fspecial('gaussian',patchSize,SigmaS);
normalizeFactor = imfilter(w,ha,padMethod);
w = cat(3,w,w,w); %make it 3d
normalizeFactor = cat(3,normalizeFactor,normalizeFactor,normalizeFactor);
tauI = imfilter(w.*I,ha,padMethod)./(eps+normalizeFactor) ;         
tauG = imfilter(w.*G,ha,padMethod)./(eps+normalizeFactor) ;         
%adaptive weight
alpha = 1 - exp(-Lambda*(I - tauG).^2);
%final result
J = alpha.*G + (1-alpha).*tauI; 

end

