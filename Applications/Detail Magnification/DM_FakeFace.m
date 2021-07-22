clear all
close all
I = double(imread('img/FE_person1_original.png'))/255;


% Dennis Newfilter. 
patchSize =3;
SigmaS = round((patchSize-1)/4);

scale =0.01; %can change to 0.75, or 0.5, if two small, such as 0.1, some artifact shows up
Lambda =0;

iter = 10;
S = I;

for n=1 : iter
    [S,w] = GVWA(S,I,SigmaS,scale);
end 

% Unsharp masking

alpha= 1;
gamma = 2;

R = S + gamma*(I-S);

%% SSIF - "A guided edge-aware smoothing-sharpening filter based on patch interpolation model and generalized Gamma distribution"

G= I;
radius = 11;
Epsilon = 0.01;
kappa = 3; % Kappa controls the sharpening/smoothing level. 
scale = 1;
J = SSIF(I,G,radius,Epsilon,kappa,scale);


close all
figure
imshow([I S R J])
hold on


