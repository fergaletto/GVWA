% Iterative version \Texture Smoothing
clear all
x = double(imread('OriginalImage.PNG'))/256;
SigmaS = 5;

scale = 2.5; 
Lambda =0;
Niter = 30; 
for i = 1:Niter
    J = GVWA(x,x,SigmaS,scale,Lambda);
    x = J;
end
figure,imshow([J])

