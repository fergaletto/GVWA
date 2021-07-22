close all
clear all

output_dir = './results/';
addpath(genpath('filter'));
addpath(genpath('denoise'));


funcs = {
            {@(in)(RF(in, 30, 0.7,5)), 'DT'}, ...
            {@(in)(L0Smoothing(in,2e-2)), 'L0'}, ...
            {@(in)(bilateralTextureFilter(in, 5, 5)), 'BTF'}, ...
            {@(in)(wlsFilter(in, 1, 1.2)), 'WLS'}, ...
            {@(in)(TreeFilterRGB_Uint8(uint8(in*255), 0.01, 3, 0.08, 4)), 'STF'}, ...
            {@(in)(tsmooth(in)), 'RTV'}, ...
            {@(in)(RollingGuidanceFilter(in, 5, 0.1, 20)), 'RGF'}, ...
            {@(in)(weightedGF(in,in,7,1, 1)), 'AnisGF'},...
            {@(in)(RollingWGF(in,in,5,0.01, 3, 10)), 'WGF'},...
            {@(in)(GAVWAe5_iter(in,1.5,0.75,20)), 'Ours'}};

        
        


% image name
imgname = 'img/rocky_cut2.jpg';

% number of iteration
max_iter = 100;
        
% load image
I = im2double(imread(imgname));
I = max(min(imresize(I, 0.5),1), 0);
[H, W, C] = size(I);

        zoom = 2;
xpos = 202; 
ypos = 174;
dxy=40;
boxsize=150;
t=1;
color = [0 1 0];

    y=I;
    y((H-boxsize+1):end, (W-boxsize+1):end, :) =imresize(y(ypos:(ypos+dxy), xpos:(xpos+dxy), :), [boxsize,boxsize]);
    y=draw_rectangle(y,xpos,ypos,dxy,dxy,t, color);
    y=draw_rectangle(y,(W-boxsize-t),(H-boxsize-t),boxsize,boxsize,t, color);
    
imwrite(y, [output_dir,'S_Original3.png']);


figure
imshow(y)
title('Original'); 
for k=1:length(funcs)
    % Choose the filter
    f = funcs{k}{1};
    f_name = funcs{k}{2};
    y = f(I);
    y((H-boxsize+1):end, (W-boxsize+1):end, :) =imresize(y(ypos:(ypos+dxy), xpos:(xpos+dxy), :), [boxsize,boxsize]);
    y=draw_rectangle(y,xpos,ypos,dxy,dxy,t, color);
    y=draw_rectangle(y,(W-boxsize-t),(H-boxsize-t),boxsize,boxsize,t, color);
        
        
    imwrite(y, [output_dir,'S_',f_name, '3.png']);
    figure
    imshow(y)
    title(f_name); 
end



%% ADd box to SDF 

SDF = im2double(imread('./filter/SDFilter-master/results/scale-space/sd-filtering_30.png'));
    SDF((H-boxsize+1):end, (W-boxsize+1):end, :) =imresize(SDF(ypos:(ypos+dxy), xpos:(xpos+dxy), :), [boxsize,boxsize]);
    SDF=draw_rectangle(SDF,xpos,ypos,dxy,dxy,t, color);
    SDF=draw_rectangle(SDF,(W-boxsize-t),(H-boxsize-t),boxsize,boxsize,t, color);
imwrite(SDF, [output_dir,'S_SDF2.png']);




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


