%This is an implementation of GFF using our filter

close all
 clear all
%% Load images
%I = im2double(imread('sourceimages/test4/Lenna.png'));
I1 = im2double(imread('results/MFF_Kid_I1.png'));
I2 = im2double(imread('results/MFF_kid_I2.png'));

%% Choice of parameters

SigmaS1=3.5;
scale1=10;
Lambda1=0;
iter1 = 2;

SigmaS2=3.5;
scale2=10;
Lambda2=0;
iter2 = 2;
% r1 = 45;
% eps1 = 0.3;
% r2 = 7;
% eps2 = 10^-6;

%% step A : two-scale image decomposition
% B1 and B2: blured images
% D1 and D2: detailed images
tic
average_filter = 1/(31*31)*ones(31,31);
B1 = convn(I1, average_filter, 'same');
B2 = convn(I2, average_filter, 'same');
D1 = I1 - B1;
D2 = I2 - B2;

figure, imshow([B1, B2;, D1, D2])
%% step B weight map construction
Ig1 = rgb2gray(I1);
Ig2 = rgb2gray(I2);

% laplacian filtering
laplacian_filter = [[0 -1 0]; [-1 4 -1]; [0 -1 0]];
H1 = convn( Ig1, laplacian_filter, 'same');
H2 = convn( Ig2, laplacian_filter, 'same');

% gaussian filtering
S1 = imgaussfilt(abs(H1), 'FilterSize', 11);
S2 = imgaussfilt(abs(H2), 'FilterSize', 11);

% maybe reshape P1 and P2
P1 = (S1 == max(S1, S2));
P2 = (S2 == max(S1, S2));

% r1, eps1, r2 and eps2 are not related to the index of I1, P1, I2, P2, etc
Wb1 = P1;
Wb2 = P2;
for n = 1: iter1
    Wb1 = GVWA(Wb1,Ig1,SigmaS1,scale1);
    Wb2 = GVWA(Wb2,Ig2,SigmaS1,scale1);
end
Wd1 = P1;
Wd2 = P2;
for n=1 : iter2
    Wd1 = GVWA(Wd1,Ig1,SigmaS2,scale2);
    Wd2 = GVWA(Wd2,Ig2,SigmaS2,scale2);
end
% normalizing weights
Sumb = Wb1 + Wb2;
Sumd = Wd1 + Wd2;
Wb1 = Wb1./Sumb;
Wd1 = Wd1./Sumd;
Wb2 = Wb2./Sumb;
Wd2 = Wd2./Sumd;


%% step C: two-scale image reconstruction

Bb = repmat(Wb1, [1 1 3]) .* B1 + repmat(Wb2, [1 1 3]) .* B2;
Db = repmat(Wd1, [1 1 3]) .* D1 + repmat(Wd2, [1 1 3]) .* D2;

F = Bb + Db;
toc
figure;
imshow([I1 I2 F]);

figure;
imshow([S1,P1,Wb1,Wd1;S2,P2,Wb2,Wd2],[0,1]);

% 
% %% Save result
imwrite(I1, 'results/MFF_Kid_I1.png');
imwrite(I2, 'results/MFF_kid_I2.png');
imwrite(F, 'results/MFF_kid_ours.png');

% %% Evaluate
addpath('evaluation/');
A = imread('results/MFF_Kid_I1.png');
B=imread( 'results/MFF_kid_I2.png');
F=imread('results/MFF_kid_ours.png');
%%


Eval(3,:) = table( 0.68865,	0.85206	,0.96305,	0.73283	,0.50355); %EGG values. 
Eval(4,:)=EvalFusion(A,B,F)
disp(['sigma_s1 = ',num2str(SigmaS1),', scale1 = ',num2str(scale1),', iter1 = ' ,num2str(iter1)])
disp(['sigma_s2 = ',num2str(SigmaS2),', scale2 = ',num2str(scale2),', iter2 = ' ,num2str(iter2)])

