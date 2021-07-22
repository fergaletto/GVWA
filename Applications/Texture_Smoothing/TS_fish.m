clear all
close all
I = double(imread('results/TS_fish_Original.png'))/255;

% Dennis Newfilter. 
SigmaS =.75 %round((patchSize-1)/4);

scale =0.75; %can change to 0.75, or 0.5, if two small, such as 0.1, some artifact shows up
Lambda =0;

iter = 10;
Je2 = I;
tic
for n=1 : iter
    [Je2,w] = GAVWAe5(Je2,I,SigmaS,scale);
end 
toc

figure
imshow([I Je2])


% imwrite(Je2, 'results/TS_fish_ours.png');