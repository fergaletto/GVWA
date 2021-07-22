function [res MSE] = RGAVWAe5(I,SigmaS,scale,iteration, MODE)
if ~exist('MODE','var')
    MODE = 1;
end

if ~exist('iteration','var')
    iteration = 4;
end

if ~exist('theta','var')
    theta = 0;
end

if ~exist('patch_size','var')
    patch_size = 5;
end
MSE = [];



switch MODE
    case 1 
        disp('Type-I: use the filter result as the guidance to filter the original image')
        res = I; 
        for i=1:iteration
            disp(['RGAVWA iteration ' num2str(i) '...']);
            for c=1:size(I,3)
                res(:,:,c)  = GAVWAe5(I(:,:,c),res(:,:,c),SigmaS,scale);
            end
            MSE(i) = immse(res, I);
        end
    case 2 
        disp('Type -II: use I as the guidance to perform iterative filtering of the result.')
        res = I;  % I think i need to change this to res=I;
        for i=1:iteration
            disp(['RGAVWA iteration ' num2str(i) '...']);
            for c=1:size(I,3)
                res(:,:,c)  = GAVWAe5(res(:,:,c),I(:,:,c),SigmaS,scale);
            end
            MSE(i) = immse(res, I);
        end
    case 3
        disp('Type-III: an iterative AVWA filter')
        res = I;
        for i=1:iteration
            disp(['RGAVWA iteration ' num2str(i) '...']);
            for c=1:size(I,3)
                res(:,:,c)  = GAVWAe5(res(:,:,c),res(:,:,c),SigmaS,scale);
            end
            MSE(i) = immse(res, I);
        end
    
end



end