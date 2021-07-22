close all
clear all
I = double((imread('img/image.png')))/255;
I =  I(10:end-10, 10:end-10, :);
[H, W, C] = size(I);
SigmaS =  1;
scale = 0.75;
iteration = [5, 10,15];
R =[];
zoom = 4;
xpos = 110;
ypos = 275;
dxy=50;
boxsize=dxy*zoom;
t=3;
color = [0,0.75,0];

for n = 1: length(iteration)
    J1 = RGAVWAe5(I,SigmaS,scale,iteration(n), 1);
    J1((H-boxsize+1):end, (W-boxsize+1):end, :) =imresize(J1(ypos:(ypos+dxy), xpos:(xpos+dxy), :), [boxsize,boxsize]);
    J1=draw_rectangle(J1,xpos,ypos,dxy,dxy,t, color);
    J1=draw_rectangle(J1,(W-boxsize-t),(H-boxsize-t),boxsize,boxsize,t, color);
    
    J2 = RGAVWAe5(I,SigmaS,scale,iteration(n), 2);
    J2((H-boxsize+1):end, (W-boxsize+1):end, :) =imresize(J2(ypos:(ypos+dxy), xpos:(xpos+dxy), :), [boxsize,boxsize]);
    J2=draw_rectangle(J2,xpos,ypos,dxy,dxy,t, color);
    J2=draw_rectangle(J2,(W-boxsize-t),(H-boxsize-t),boxsize,boxsize,t, color);
    
    J3 = RGAVWAe5(I,SigmaS,scale,iteration(n), 3);
    J3((H-boxsize+1):end, (W-boxsize+1):end, :) =imresize(J3(ypos:(ypos+dxy), xpos:(xpos+dxy), :), [boxsize,boxsize]);
    J3=draw_rectangle(J3,xpos,ypos,dxy,dxy,t, color);
    J3=draw_rectangle(J3,(W-boxsize-t),(H-boxsize-t),boxsize,boxsize,t, color);
    
    R = [R;J1, J2, J3];
end

figure
imshow(R)
% hold on
% FS= 12;
% gtext('$N_{iter} = 5$','interpreter','latex', 'rotation',90,'fontsize',FS,'HorizontalAlignment','center')
% gtext('$N_{iter} = 10$','interpreter','latex', 'rotation',90,'fontsize',FS,'HorizontalAlignment','center')
% gtext('$N_{iter} = 15$','interpreter','latex', 'rotation',90,'fontsize',FS,'HorizontalAlignment','center')
% gtext('Type I','interpreter','latex','fontsize',FS,'HorizontalAlignment','center')
% gtext('Type II','interpreter','latex','fontsize',FS,'HorizontalAlignment','center')
% gtext('Type III','interpreter','latex','fontsize',FS,'HorizontalAlignment','center')

function O=draw_rectangle(I,x,y,dx,dy,t, color)

O=im2double(I);
x0 = x-t;
y0 = y-t;
for n=1:3
    O(y:y+t,x:x+dx+t,n)= color(n);
    O(y:y+dy,x:x+t,n)= color(n);
    O(y+dy:y+dy+t,x:x+dx+t,n)= color(n);
    O(y:y+dy+t,x+dx:x+dx+t,n)= color(n);
end
end