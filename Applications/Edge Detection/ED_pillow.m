clear all
close all
I = double(imread('img/ED_pillow_original.png'))/255;


patchSize =5;
SigmaS = ((patchSize-1)/4);

scale =0.5; 
Lambda =1;

iter = 3;
S = I;
for n=1 : iter
    [S,w] = GAVWAe5(S, I ,SigmaS,scale);
end 

B=rgb2gray(S);
[GX,GY] = gradient(B/2);
E = sqrt(GX.^2+GY.^2);
E = rescale(E);

B=rgb2gray(I);
[GX,GY] = gradient(B/2);
EE = sqrt(GX.^2+GY.^2);
EE = rescale(EE);


close all
figure
imshow([I S ; repmat([EE E], 1,1,3)])
hold on


