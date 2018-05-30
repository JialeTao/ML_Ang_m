%% 二维数据投影
clear all
close all
clc
load('data1.mat');
plot(X(:,1),X(:,2),'bo');
axis('square');
[X_norm mu sigma]=featureNormalize(X);
[U S]=pca(X_norm);
hold on
drawLine(mu,mu+2*U(:,1)'*S(1,1),'-k','linewidth',2);
drawLine(mu,mu+2*U(:,2)'*S(2,2),'-k','linewidth',2);
hold off

figure
plot(X_norm(:,1),X_norm(:,2),'go');
axis('square');
hold on
X_pro=projectData(X_norm,U,1);
X_rec=recoverData(X_pro,U,1);
plot(X_rec(:,1),X_rec(:,2),'ro');
for i=1:size(X_rec,1)
    drawLine(X_norm(i,:),X_rec(i,:),'-k');
end
hold off

%% 特征脸投影
clear all
close all
clc
load('faces.mat');
figure
displayData(X(1:100,:));
[X_norm mu sigma]=featureNormalize(X);
[U S]=pca(X_norm);
figure
displayData(U(:,1:36)');
title('eigen faces');
X_pro=projectData(X_norm,U,100);
X_rec=recoverData(X_pro,U,100);
figure
displayData(X_norm(1:100,:));
title('original faces');
figure
displayData(X_rec(1:100,:));
title('faces recovered from top100 eigenvectors')