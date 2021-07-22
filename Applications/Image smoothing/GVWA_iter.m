function y = GVWA_iter(I,SigmaS,scale,iter);

y  = I;
for n=1 : iter
    [y,w] = GVWA(y, I,SigmaS,scale);
end 


end
