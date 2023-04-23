%% 高斯过程回归GRP
clc;clear;
load data.mat;%第一列为自变量（日期），第二列为因变量（销售额）
load x_predict;%预测自变量
[m,n]=size(x_predict);
result=zeros(m,1);
y_predict=GRP(data,x_predict);
