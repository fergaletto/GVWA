clear
close all

%------read images---------
%[imagename1, imagepath1]=uigetfile('./images/*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
%A=imread(strcat(imagepath1,imagename1));    
%[imagename2, imagepath2]=uigetfile('./images/*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
%B=imread(strcat(imagepath2,imagename2));  
addpath('evaluation/')


A = imread('results/MFF_book_I1.png');
B = imread('results/MFF_book_I2.png');

A = double(A)/255;
B = double(B)/255;

if size(A)~=size(B)
    error('two images are not the same size.');
end

if size(A,3)>1
    A_gray=rgb2gray(A);
    B_gray=rgb2gray(B);
else
    A_gray=A;
    B_gray=B;
end
%figure; imshow(A,[]);
%figure; imshow(B,[]);

%figure; imshow(A_gray,[]);
%figure; imshow(B_gray,[]);


[high, with] = size(A_gray);
tic;
% Parameters for Guided Filter 
r =5; eps = 0.3;
w =7;

h = fspecial('average', [w w]);
averA = imfilter(A_gray,h,'replicate');
averB = imfilter(B_gray,h,'replicate');
%figure; imshow(averA,[]);
%figure; imshow(averB,[]);


smA = abs(A_gray - averA);
smB = abs(B_gray - averB);
% figure; imshow(smA,[]);
% figure; imshow(smB,[]);
%%
close all
SigmaS =3.5
scale = 1
Lambda = 0
iter = 1
gsmA = (smA);
gsmB = (smB);
for n = 1 : iter
    gsmA = GVWA(gsmA,A_gray,SigmaS,scale);
    gsmB = GVWA(gsmB,B_gray,SigmaS,scale);
end

% figure; imshow(gsmB,[]);
%

wmap = (gsmA > gsmB);
% figure; imshow(wmap,[]);

ratio=0.01;
area=ceil(ratio*high*with);
tempMap1=bwareaopen(wmap,area);
tempMap2=1-tempMap1;
tempMap3=bwareaopen(tempMap2,area);
wmap=1-tempMap3;

mmap = wmap.*A_gray + (1-wmap).*B_gray;
% figure; imshow(wmap,[]);
%figure; imshow(mmap,[]);

gmap = wmap;
for n = 1 : iter
    gmap = GVWA(gmap,mmap,SigmaS,scale);
end

figure; imshow([rescale(smA), rescale(smB) ; gsmA, gsmB;gmap, wmap],[0 1 ]);
figure; imshow([gmap, wmap], [0, 1]);
%
% fuse image
if size(A,3)>1
    wmap=repmat(wmap,[1 1 3]);
    gmap=repmat(gmap,[1 1 3]);
end

IF = A.*wmap + B.*(1-wmap);% Initial fused image
% figure; imshow(IF,[]);
F_GF2 = A.*gmap + B.*(1-gmap);
F_GF2 = uint8(F_GF2*255);
t1=toc

A = uint8(A*255);
B = uint8(B*255);


figure; imshow([A, B, F_GF2]);
imwrite(F_GF2, 'results/MFF_book_Ours2.png');

% %% Evaluate
addpath('evaluation/');
A = imread('results/MFF_book_I1.png');
B=imread( 'results/MFF_book_I2.png');
F=imread('results/MFF_book_Ours2.png');
%%


Eval(3,:) = table(0.67992,	0.8935,	0.98554,	0.80577,	0.63095); %GFDF values. 
Eval(4,:)=EvalFusion(A,B,F)
disp(['sigma_s = ',num2str(SigmaS),', scale = ',num2str(scale),', iter = ' ,num2str(iter)])





