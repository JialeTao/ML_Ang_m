function k=GaussianKernel(x1,x2,sigma)
k=exp(-sum((x1-x2) .^ 2)/2/sigma/sigma);
end

