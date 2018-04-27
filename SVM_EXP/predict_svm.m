function p=predict_svm(model,X)
m=size(X, 1);
p=zeros(m, 1);
pre=zeros(m, 1);

if strcmp(func2str(model.kernel_fun), 'LinearKernel')
    p=X*model.w+model.b;
elseif strfind(func2str(model.kernel_fun), 'GaussianKernel')
    X1=sum(X.^2, 2);
    X2=sum(model.X.^2, 2)';
    K=bsxfun(@plus, X1, bsxfun(@plus, X2, - 2 * X * model.X'));
    K=model.kernel_fun(1, 0) .^ K;
    K=bsxfun(@times, model.y', K);
    K=bsxfun(@times, model.alpha', K);
    p=sum(K, 2);
else
    fori =1:m
        prediction = 0;
        for j=1:size(model.X, 1)
            prediction=prediction+...
                model.alpha(j)*model.y(j) * ...
                model.kernel_fun(X(i,:)',model.X(j,:)');
        end
        p(i)=prediction+model.b;
    end
end
pre(p >= 0)=1;
pre(p <  0)=0;
end

