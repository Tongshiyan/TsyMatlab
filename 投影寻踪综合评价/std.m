%% 投影寻踪综合评价 优化GA
function [z,x]=std(data,a)

%% 初始化
[n,m]=size(data);%n为样本个数，m为指标个数

%% 数据归一化
x=zeros(n,m);%初始化x
for i=1:n
    for j=1:m
        x(i,j)=(data(i,j)-min(data(:,j)))/(max(data(:,j))-min(data(:,j)));
    end
end

%% 计算z值
z=zeros(n,1);
for i = 1:n
    sum0 = 0;
    for j = 1:m
        sum0 = sum0 + a(j)*x(i,j);
    end
    z(i) = sum0;
end
end