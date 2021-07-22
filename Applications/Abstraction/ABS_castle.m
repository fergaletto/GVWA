clear all
close all
I = double(imread('img/ABS_castle_original.png'))/255;


SigmaS = 1;
scale =0.75;
Lambda =0;
iter = 10;
S =I;
for i=1:iter
    S = GVWA(S, I,SigmaS,scale);
end

%% Determine gradient magnitude of luminance.
max_gradient      = 0.1;    % maximum gradient (for edges)
min_edge_strength = 0.1;    % minimum gradient (for edges)

E=rgb2gray(S);
[GX,GY] = gradient(E);
G = sqrt(GX.^2+GY.^2);
G(G>max_gradient) = max_gradient;
G = G/max_gradient;

%% Create a simple edge map using the gradient magnitudes.
E = G; E(E<min_edge_strength) = 0;
E = 1-E;

C = S.*E;

close all
figure
imshow([I S C repmat(E, 1, 1, 3)])


