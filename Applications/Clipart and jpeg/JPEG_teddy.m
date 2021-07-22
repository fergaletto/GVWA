
clear all
close all
X = double(imread('img/JPEG_Teddy_HQ.png'))/255;
imwrite(X,'results/JPEG_Teddy_LQ.jpg','Quality',10);    %# JPEG output (lossy): 

I = double(imread('results/JPEG_Teddy_LQ.jpg'))/255;
 
SigmaS = 0.75;
scale =0.5;

iter = 20;
S = I;
for n=1 : iter
    [S,w] = GVWA(S,I,SigmaS,scale);
end 



figure
imshow([X I S])

% imwrite(X, 'results/JPEG_Teddy_HQ.png');
% imwrite(I, 'results/JPEG_Teddy_LQ.png');
% imwrite(S, 'results/JPEG_Teddy_Restored.png');
%
MSE_LQ = immse(I, X)
MSE_Ours = immse(S, X)

PSNR_LQ = psnr(I, X)
PSNR_Ours = psnr(S, X)
