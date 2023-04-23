%% K-交叉验证
load data.mat%载入数据
[m,n]=size(data);
k=3;%均分个数
temp=randperm(m);%随机打乱已知样本数据
num=round(m/k);
x=cell(k,1);
for i=1:k-1
    x{i}=data(temp((i-1)*num+1:i*num),:)';
end
x{k}=data(temp((i-1)*num+1:end),:)';