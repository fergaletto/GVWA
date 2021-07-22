clear all
close all
I = double(imread('angel.png'))/255;

SigmaS = 0.5

scale =0.5; %can change to 0.75, or 0.5, if two small, such as 0.1, some artifact shows up

iter = 50;
Je2 = I;
for n=1 : iter
    [Je2,w] = GVWA(Je2, I,SigmaS,scale);
end 
%%
iter = 10
% Guided filter. 
GF = I;
for n=1 : iter
    GF = imguidedfilter(I, GF, 'NeighborhoodSize', 7, 'DegreeOfSmoothing',0.01);

end 

figure
imshow([I GF Je2])
 
