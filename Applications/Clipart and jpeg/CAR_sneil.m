clear all
close all
I = double(imread('img/CAR_sneil_original.png'))/255;

SigmaS = 0.5;

scale =0.75; 
iter = 30;
S = I;

for n=1 : iter
    [S,w] = GVWA(S,I,SigmaS,scale);
end 

figure
imshow([I S])
hold on
