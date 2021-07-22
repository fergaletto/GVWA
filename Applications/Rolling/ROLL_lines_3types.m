close all
clear all
I = double((imread('img/1.png')))/255;

[H, W, C] = size(I);
x1 = 84;
y1 = 18;
w = 3;

x2 = 10 ;
y2 = 27;
w = 64;


ss = round(W/2);
ss2 = W-ss;


SigmaS =  [1.5];
scale = [0.5];
R4 =[];
R3 = [];


P1 = I(x1:(x1+w), y1:(y1+w), :);
P2 = I(x2:(x2+w), y2:(y2+w), :);
R3 = [I;[imresize(P1,[ss,ss]), imresize(P2,[ss,ss2])]];
R4 =[I;[imresize(P1,[ss,ss]), imresize(P2,[ss,ss2])]];
R5 =[I;[imresize(P1,[ss,ss]), imresize(P2,[ss,ss2])]];
R6 =[];    
R4 =[];
R5 = [];

for i = 1: length(SigmaS)

    for n=1 : length(scale)

        iteration = 500
        % mode 1
        [J3 MSE] = RGAVWAe5(I,SigmaS(i),scale(n),iteration, 1);
        P1 = J3(x1:(x1+w), y1:(y1+w), :);
        P2 = J3(x2:(x2+w), y2:(y2+w), :);
        R3 = [R3 [J3;[imresize(P1,[ss,ss]), imresize(P2,[ss,ss2])]]];
        

        
        [J4 MSE1] = RGAVWAe5(I,SigmaS(i),scale(n),iteration, 2);
        P1 = J4(x1:(x1+w), y1:(y1+w), :);
        P2 = J4(x2:(x2+w), y2:(y2+w), :);
        R4 = [R4 [J4;[imresize(P1,[ss,ss]), imresize(P2,[ss,ss2])]]];
        



        [J5 MSE2] = RGAVWAe5(I,SigmaS(i),scale(n),iteration, 3);
        P1 = J5(x1:(x1+w), y1:(y1+w), :);
        P2 = J5(x2:(x2+w), y2:(y2+w), :);
        R5 = [R5 [J5;[imresize(P1,[ss,ss]), imresize(P2,[ss,ss2])]]];
        figure(1)
        plot(MSE,'LineWidth', 2)
        hold on,  plot(MSE1,'LineWidth', 2), plot(MSE2,'LineWidth', 2)
       grid on
    end
    R6 = [R3  R4 R5];
    R3 = [];R4 = [];R5 = [];
    
end
%%

 legend('Type I', 'Type II', 'Type III', 'FontSize',12);
xlabel('Iterations','FontSize',12,'FontWeight','bold','Color','k')
ylabel('MSE','FontSize',12,'FontWeight','bold','Color','k')
 grid on


figure(2)
imshow([R6])
hold on

rectangle('Position', [y1, x1, w, w], 'EdgeColor','r', 'LineWidth', 2)
rectangle('Position', [y2, x2, w, w], 'EdgeColor','b', 'LineWidth', 2)

