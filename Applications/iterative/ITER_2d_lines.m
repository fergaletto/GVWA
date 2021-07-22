clear all
close all

I = double(imread('1.png'))/255;

patchSize = 3;
Sigma = round((patchSize-1)./4);

scale = 1
Lambda = 0.5;
iter = [1 2 5 10 50 100];
R=[I];
d=[];
% original weight
for n = 1 : length(iter)
    J = I;
    for i = 1 : iter(n)
        [J,kk] = GAVWAe5(J, J,Sigma,scale);
        
    end
    imwrite(J, ['results/ITER_',num2str(iter(n)), '.png']);
    R =[R J];
end

figure
imshow([R])
hold on
