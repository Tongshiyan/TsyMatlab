% 主函数
clc;clear
load data.mat
data=zscore(data);
K=4;%簇的数目
[kinds,loss] = iterative_process(K,data,10);
