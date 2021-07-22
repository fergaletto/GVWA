function [J,w] = GAVWAe5(I,G,SigmaS,scale)

%input: I -- image to be processing I \in [0,1]
%       G -- guidance image G \in [0,1]
%       SigmaS -- bilateral spacial parameter, large ->larger scale object
%       smoothed out
%       scale -- bilateral range parameter, scale<1 -> sharper results

padMethod = 'symmetric';
patchSize = floor(4*SigmaS) + 1;
if mod(patchSize,2) == 0
   patchSize = patchSize + 1;
end

N = patchSize*patchSize;
hs = ones(patchSize)/N;

muG = (imfilter(G, hs,padMethod));
muGG = (imfilter(G.*G, hs,padMethod));
w = max(max(0,muGG - muG.*muG),[],3);

SigmaR = scale*mean(w(:));
w = w./SigmaR;
w = 1./(1+w.^2); 

ha = fspecial('gaussian',patchSize,SigmaS);
normalizeFactor = imfilter(w,ha,padMethod);
if size(I, 3) == 3
    w = cat(3,w,w,w); %make it 3d
    normalizeFactor = cat(3,normalizeFactor,normalizeFactor,normalizeFactor);
end
J = imfilter(w.*I,ha,padMethod)./(eps+normalizeFactor) ;
end

