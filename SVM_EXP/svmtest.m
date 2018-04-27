clear all
close all
clc
load('data1.mat');
plot_Trainset(X, y);
C1=1;C2=1000;
figure
model =mysvm(X,y,C1,0.001,@LinearKernel);
plot_linearbound(X, y, model);
figure
model =mysvm(X,y,C2,0.001,@LinearKernel);
plot_linearbound(X, y, model);

clear all
close all
clc
load('data2.mat');
figure
plot_Trainset(X, y);
C = 1; sigma = 0.028;
model= mysvm(X, y, C, 0.001, @(x1, x2) GaussianKernel(x1, x2, sigma)); 
figure
plot_bound(X, y, model);
