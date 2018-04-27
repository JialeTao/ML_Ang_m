function plot_Trainset(X, y)
class1= find(y == 1); class2 = find(y == 0);
plot(X(class1, 1), X(class1, 2), 'ko','MarkerFaceColor', 'r', 'MarkerSize', 5)
hold on;
plot(X(class2, 1), X(class2, 2), 'ko', 'MarkerFaceColor', 'g', 'MarkerSize', 5)
hold off;
end
