% Iterative version \Texture Smoothing
clear all
close all 
clc


zoom = 2;
xpos = 100;
ypos = 490;
dxy=80;
boxsize=300;%dxy*zoom;
t=4;
color = [1,0,0];


x = double(imread('img/Input_Fish.png'))/256;
x = gpuArray(x);
        [H,W,C]=size(x);
SigmaS = 0.5;
scale = 0.5; 
Lambda =0;
J=x;
for i = 1:500
    J = GVWA(J,x,SigmaS,scale);
end


        
figure,imshow([x, J])

imwrite(J, 'results/SS_Fish_ours.png')


