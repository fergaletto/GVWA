close all
clear all;
I = double(imread('img/cat.jpg'))/255;
patchSize =5;

R2=[];

[H, W, C] = size(I);

Sigma = [1 5];
scale = [0.1 5] 
iter = [1 1 1 1 1 1]


zoom = 2;
xpos = 44;
ypos = 44;
dxy=30;
boxsize=80;%dxy*zoom;
t=1;
color = [1];


for n=1 : length(Sigma)
    R=[];
    for m =1 : length(scale)
        J = I;
        for i = 1 : iter(n)
            J = GAVWAe5(J, I,Sigma(n),scale(m));    
        end 
        J((H-boxsize+1):end, (W-boxsize+1):end, :) =imresize(J(ypos:(ypos+dxy), xpos:(xpos+dxy), :), [boxsize,boxsize]);
        J=draw_rectangle(J,xpos,ypos,dxy,dxy,t, color);
        J=draw_rectangle(J,(W-boxsize-t),(H-boxsize-t),boxsize,boxsize,t, color);
        imwrite(J, ['results/PS_flower_', num2str(n),'_', num2str(m),'.png'] )
        R = [R J];
    end
    R2 = [R2;R];
end

figure
imshow(R2)

gtext(['$\sigma_s = $', num2str(Sigma(1))],'HorizontalAlignment','center', 'rotation',90, 'fontname', 'arial','fontsize',12,'Interpreter','latex');
gtext(['$\sigma_s = $', num2str(Sigma(2))],'HorizontalAlignment','center', 'rotation',90, 'fontname', 'arial','fontsize',12,'Interpreter','latex');
gtext(['$s = $', num2str(scale(1))],'HorizontalAlignment','center', 'fontname', 'arial','fontsize',12,'Interpreter','latex');
gtext(['$s = $', num2str(scale(2))],'HorizontalAlignment','center', 'fontname', 'arial','fontsize',12,'Interpreter','latex');

function O=draw_rectangle(I,x,y,dx,dy,t, color)

O=im2double(I);
x0 = x-t;
y0 = y-t;
for n=1:1
    O(y:y+t,x:x+dx+t,n)= color(n);
    O(y:y+dy,x:x+t,n)= color(n);
    O(y+dy:y+dy+t,x:x+dx+t,n)= color(n);
    O(y:y+dy+t,x+dx:x+dx+t,n)= color(n);
end
end
