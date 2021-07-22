function J = RollingWGF(I,G,patchSize,Epsilon, MODE, iter)
J = I;
for n=1:iter
    J = weightedGF(J,G,patchSize,Epsilon, MODE);
end

end
