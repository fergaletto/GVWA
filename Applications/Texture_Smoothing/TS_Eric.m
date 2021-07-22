close all
I = double(imread('results/TS_eric_original.png'))/255;

[H, W, C] = size(I);

patchSize = 7;
SigmaS = ((patchSize-1)/4);

scale =0.5; 
iter = 15;

Je2 = I;
for n=1 : iter
    [Je2,w] = GAVWAe5(Je2, I,SigmaS,scale);
end 
% 
% imwrite(Je2, 'results/TS_eric_ours.png')
close all
figure
imshow([I Je2])
