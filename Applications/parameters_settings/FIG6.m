Niter =[10 100 1000 10000];
x = double(imread('peppers.png'))/256;
G = x;
sigma_s = 1.5;
s = 0.5;
 
sigma_s = 1;

s = 0.01;
tic;[J1s01,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,1);toc
tic;[J10s01,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,10);toc
tic;[J100s01,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,100);toc
tic;[J1000s01,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,1000);toc
s = 0.5;
tic;[J1s05,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,1);toc
tic;[J10s05,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,10);toc
tic;[J100s05,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,100);toc
tic;[J1000s05,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,1000);toc
s = 1;
tic;[J1s1,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,1);toc
tic;[J10s1,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,10);toc
tic;[J100s1,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,100);toc
tic;[J1000s1,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,1000);toc

figure(1)
imshow([J1s01 J10s01 J100s01 J1000s01;J1s05 J10s05 J100s05 J1000s05;J1s1 J10s1 J100s1 J1000s1 ])
FS = 14;
gtext('$\sigma_s = 1$','interpreter','latex','fontsize',FS,'HorizontalAlignment','center')
gtext('$s = 0.01$','interpreter','latex', 'rotation',90,'fontsize',FS,'HorizontalAlignment','center')
gtext('$s = 0.5$','interpreter','latex', 'rotation',90,'fontsize',FS,'HorizontalAlignment','center')
gtext('$s = 1$','interpreter','latex', 'rotation',90,'fontsize',FS,'HorizontalAlignment','center')
gtext('$N_{iter} = 1$','interpreter','latex','fontsize',FS,'HorizontalAlignment','center')
gtext('$N_{iter} = 10$','interpreter','latex','fontsize',FS,'HorizontalAlignment','center')
gtext('$N_{iter} = 100$','interpreter','latex','fontsize',FS,'HorizontalAlignment','center')
gtext('$N_{iter} = 1000$','interpreter','latex','fontsize',FS,'HorizontalAlignment','center')

%% 

%2nd case
sigma_s = 2;
s = 0.01;
tic;[J1s01,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,1);toc
tic;[J10s01,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,10);toc
tic;[J100s01,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,100);toc
tic;[J1000s01,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,1000);toc
s = 0.5;
tic;[J1s05,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,1);toc
tic;[J10s05,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,10);toc
tic;[J100s05,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,100);toc
tic;[J1000s05,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,1000);toc
s = 1;
tic;[J1s1,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,1);toc
tic;[J10s1,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,10);toc
tic;[J100s1,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,100);toc
tic;[J1000s1,MSE] = GAVWAe6Type2GPU(x,G,sigma_s,s,1000);toc

figure(2)
imshow([J1s01 J10s01 J100s01 J1000s01;J1s05 J10s05 J100s05 J1000s05;J1s1 J10s1 J100s1 J1000s1 ])
gtext('$\sigma_s = 2$','interpreter','latex','fontsize',FS,'HorizontalAlignment','center')
gtext('$s = 0.01$','interpreter','latex', 'rotation',90,'fontsize',FS,'HorizontalAlignment','center')
gtext('$s = 0.5$','interpreter','latex', 'rotation',90,'fontsize',FS,'HorizontalAlignment','center')
gtext('$s = 1$','interpreter','latex', 'rotation',90,'fontsize',FS,'HorizontalAlignment','center')
gtext('$N_{iter} = 1$','interpreter','latex','fontsize',FS,'HorizontalAlignment','center')
gtext('$N_{iter} = 10$','interpreter','latex','fontsize',FS,'HorizontalAlignment','center')
gtext('$N_{iter} = 100$','interpreter','latex','fontsize',FS,'HorizontalAlignment','center')
gtext('$N_{iter} = 1000$','interpreter','latex','fontsize',FS,'HorizontalAlignment','center')