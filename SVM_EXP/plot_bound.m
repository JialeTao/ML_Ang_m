function plot_bound(X, y, model, varargin)

plot_Trainset(X, y);
x1plot=linspace(min(X(:,1)),max(X(:,1)),100)';
x2plot=linspace(min(X(:,2)),max(X(:,2)),100)';
[X1,X2]=meshgrid(x1plot, x2plot);
vals=zeros(size(X1));
for i=1:size(X1, 2)
   this_X=[X1(:,i),X2(:,i)];
   vals(:,i)=predict_svm(model,this_X);
end
hold on
contour(X1,X2,vals,[0.5 0.5],'b');
hold off;

end
