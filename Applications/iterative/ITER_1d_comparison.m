clear all
close all

I = double(imread('1.png'))/255;

patchSize = 5;
Sigma = round((patchSize-1)./4);
line_of_interest = 150;
rows = [1:100];
scale = 1
Lambda = 1;
iter = [1 10 100];
R=[I((line_of_interest-length(rows)/2):(line_of_interest+length(rows)/2), rows, :)];
d=[];

figure
m=2;
mn=length(iter)+1;
subplot(m,mn,1)
imshow(I((line_of_interest-length(rows)/2):(line_of_interest+length(rows)/2), rows, :))
subplot(m,mn,1+mn)
plot(I(line_of_interest, rows, 1),'k', 'linewidth', 1); xlabel('Input','FontSize',12 ,'Interpreter','latex')
ylim([0.3, 1.1])
grid on
hold on


% original weight
for n = 1 : length(iter)
    J = I;
    for i = 1 : iter(n)
        [J,kk] = GAVWAe5(J,J, Sigma,scale);
        
    end
    
    subplot(m,mn,n+1)
    imshow(J((line_of_interest-length(rows)/2):(line_of_interest+length(rows)/2), rows, :))
    subplot(m,mn,n+1+mn)

    plot(J(line_of_interest, rows, 1), 'k', 'linewidth', 1);xlabel([' $N_{iter}$ =', num2str(iter(n))],'FontSize',12,'Interpreter','latex' )
    grid on
    ylim([0.3, 1.1])
    
    %imwrite(J, ['ITER_1d_',num2str(iter(n)), '.png']);
    R =[R J((line_of_interest-length(rows)/2):(line_of_interest+length(rows)/2), rows, :)];
end

