%% MAD算法剔除离群值
clc;clear
load x.mat;
[m,n]=size(x);
new=zeros(m,n);
for i=1:m
%计算所有元素的中位值
old=x(i,:);
if mod(n,2)==1
    x0=sort(old);%对向量进行排序
    middle=x0((n+1)/2);
else
    x0=sort(old);
    middle=(x0(n/2)+x0(n/2+1))/2;
end
 %计算所有元素与中位值的绝对偏差
x1=abs(old-middle);
%取绝对偏差的中位值
if mod(n,2)==1
    x0=sort(x1);
    middle1=x1((n+1)/2);
else
    x0=sort(x1);
    middle1=(x1(n/2)+x1(n/2+1))/2;
end
%确定参数c对数据调整
c=1;
for j=1:n
    if old(j)>middle+c*middle1
        new(i,j)=middle+c*middle1;
    elseif old(j)<middle-c*middle1
       new(i,j)=middle-c*middle1;
    else 
        new(i,j)=old(j);
    end
end
end