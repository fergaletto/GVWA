clear all
close all


SigmaS = 1;
N = [200:100:2000];
SigmaR = 0.01;
iter = 1;
MSE=[];
d=[];
l= cell(1,length(SigmaS));

% original weight
    times1=[];
    times2=[];
    times3=[];
    for n=1:length(N)
        J = (rand(N(n),N(n), 'double'));
        J = repmat(J, 1,1,3);

        tic

        for i = 1 : iter
            [J,kk] = GAVWAe4(J, J,SigmaS,SigmaR);
        end
        times1=[times1, toc];

 
        
    end
  
figure
scatter(N(3:end).^2, times1(3:end)/iter, 50, 'r*');
hold on
lsline
grid on
xlabel('$N_{iter}$', 'FontSize', 24,'Interpreter','latex');
ylabel('Time [sec]', 'FontSize', 24,'Interpreter','latex');

