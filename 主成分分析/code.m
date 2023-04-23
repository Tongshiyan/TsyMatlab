%% 主成分分析 PCA
%不要用于评价模型
%可以用到聚类模型
%可以帮助回归模型解决多重共线性的问题
clc;clear
load x.mat;
[m,n]=size(x);%m个样本，n个指标
%% 标准化处理
X=zscore(x);
%% 计算标准化矩阵的协方差矩阵
R=cov(X);
disp('相关系数矩阵:')
disp(R)
%% 计算协方差矩阵的特征向量和特征值
[V,D]=eig(R);%V对应特征向量，D为对角阵对应特征值
V=rot90(V)';
%% 计算主成分贡献率以及累计贡献率
cv=diag(D);%得到D的对角线元素，即特征值
cv=cv(end:-1:1);
p=cv/n;%各指标贡献率
sum_p=cumsum(p);%得到累计贡献率
disp('贡献率:')
disp(p')
disp('累计贡献率')
disp(sum_p')
num=input('根据累计贡献率（参考值>0.8）时的主成分个数');
disp('得到的主成分的荷载是')
disp(V(:,1:num))
out=x*V(:,1:num);