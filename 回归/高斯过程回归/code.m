%% 高斯过程回归GRP
clc;clear;
load data.mat;%data数据样本前1：6个为自变量，7：10为输出因变量
load x_predict;%预测自变量
[m,n]=size(x_predict);
result=zeros(m,4);%四个模型输出
model_test=zeros(4,1);
for i=1:4
    [result(:,i),model_test(i)]=GRP(0.8,i);
end
