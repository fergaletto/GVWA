%This is a comparison with the bilateral filer

clear all
close all


SigmaS = 1;
N = [1000:100:2000];
SigmaR = 0.01;
iter = 1;
MSE=[];
d=[];
l= cell(1,length(SigmaS));

% original weight
    times1=[];
    times2=[];
    times3=[];
    times4=[];
    times5=[];
    times6=[];
    for n=1:length(N)
        RND= (rand(N(n),N(n), 'double'));
        RND = repmat(RND, 1,1,3);
        J = RND;
        tic
        J = GAVWAe4(J, J,1,SigmaR);
        times1=[times1, toc];
        
%         J = RND;
%         tic
%         J = GAVWAe4(J, J,3,SigmaR);
%         times2=[times2, toc];
%         
%         J = RND;
%         tic
%         J = GAVWAe4(J, J,6,SigmaR);
%         times3=[times3, toc];
%         
        
        J = RND;
        [J, t] = bilateralFilter(J, 5, SigmaS, SigmaR);
        times4=[times4, t];
%  
%          J = RND;
%         [J, t] = bilateralFilter(J, 5, 3, SigmaR);
%         times5=[times5, t];
%         
%          J = RND;
%         [J, t] = bilateralFilter(J, 5, 6, SigmaR);
%         times6=[times6, t];
        
    end
  
figure
scatter(N.^2, times1, 25, 'r');
hold on
lsline
% scatter(N.^2, times2, 25, 'g');
% hold on
% lsline
% scatter(N.^2, times3, 25, 'b');
% hold on
% lsline
grid on
xlabel('N_{iter}', 'FontSize', 24);
ylabel('Time [sec]', 'FontSize', 24);

figure
scatter(N.^2, times4, 25, 'r');
hold on
% lsline
% scatter(N.^2, times5, 25, 'g');
% hold on
% lsline
% scatter(N.^2, times6/iter, 25, 'b');
% hold on
% lsline
grid on
xlabel('N_{iter}', 'FontSize', 24);
ylabel('Time [sec]', 'FontSize', 24);


