clear all
close all
I = double(imread('results/TS_fish_Original.png'))/255;

SigmaS =.75 

scale =0.75; %
Lambda =0;

iter = 10;
Je2 = I;
tic
for n=1 : iter
    [Je2,w] = GVWA(Je2,I,SigmaS,scale);
end 
toc

figure
imshow([I Je2])


