function plot_linearbound(X, y, model)
w = model.w;
b = model.b;
xp = linspace(min(X(:,1)), max(X(:,1)), 100);
yp = - (w(1)*xp + b)/w(2);
plot_Trainset(X, y);
hold on;
plot(xp, yp, '-b'); 
hold off
end
