close all
clear all
i  = imread('peppers.png');
i = im2double(i);

J =i;

iter = 10;
SigmaS = 2;
scale = 0.25;


for n=1 : iter
    J = GVWA(J,i,SigmaS,scale);
end 

imshow([i, J])