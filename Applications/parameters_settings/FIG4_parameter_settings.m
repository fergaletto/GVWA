close all
clear all;
I = double(imread('img/image.png'))/255;

patchSize =5;
line_of_interest = 300;

R=[];
[H, W, C] = size(I);
x1 = 283;
y1 = 123;
w = 64;

x2 = 440;
y2 = 218;
w = 64;


ss = round(W/2);
ss2 = W-ss;
P1 = I(x1:(x1+w), y1:(y1+w), :);
P2 = I(x2:(x2+w), y2:(y2+w), :);
figure(1)
m=4;
mn=1;
subplot(m,mn,1)
plot(I(line_of_interest, :, 1), 'r', 'linewidth', 0.5); xlabel('Input image','FontSize',10 )
hold on


R2 = [I;[imresize(P1,[ss,ss]), imresize(P2,[ss,ss2])]];
patchSize = [5 11 11];
Sigma = round((patchSize-1)./4);
scale = [1 1 0.1] 
Lambda = 0;
iter = [1 1 1]
for n=1 : length(patchSize)

    J = I;
    for i = 1 : iter(n)
        [J,kk] = GAVWAe5(J, I,Sigma(n),scale(n));
    end 
    
    P1 = J(x1:(x1+w), y1:(y1+w),:);
    P2 = J(x2:(x2+w), y2:(y2+w),:);
    R2 = [R2 [J;[imresize(P1,[ss,ss]), imresize(P2,[ss,ss2])]]];
    subplot(m,mn,n+1); 
    plot(J(line_of_interest, :, 1), 'k', 'linewidth', 0.5);xlabel(['\sigma_s =', num2str(Sigma(n)),' scale =', num2str(scale(n)),' N_{iter} =', num2str(iter(n))],'FontSize',10 )
    grid on
end


