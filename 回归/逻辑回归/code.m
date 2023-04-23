%% 逻辑回归
clc;clear

load data.mat;%载入数据
[m,n]=size(data);
temp=randperm(size(data,1));%随机打乱已知样本数据
num=round(size(data,1)*0.8);%80%的数据分为训练组
train_x=data(temp(1:num),1:n-1);%训练组的x
train_y=data(temp(1:num),n);%训练组的y
test_x=data(temp(num+1:m),1:n-1);%测试组的x
test_y=data(temp(num+1:m),n);%测试组的y

chef=glmfit(train_x,train_y,'binomial','logit');%得到回归系数

%% 模型评价
test_y0=zeros(size(test_x,1),1);%初始化预测的概率1200*1
test=zeros(size(test_x,1),1);%初始化预测的结果1200*1
for i=1:size(test_x,1)
    sum0=chef(1);
    for j=2:n
    sum0=sum0+chef(j)*test_x(i,j-1);
    end
    %sum0=chef(1)+text_x(i,:)*chef(2:end);
    test_y0(i)=sigmoid(sum0);
     if test_y0(i)>=0.5
        test(i)=1;
    else
        test(i)=0;
    end
end

correct=sum(test==test_y)/size(test_x,1);
disp('模型准确率为：')
disp([num2str(correct*100) '%'])

disp('-----------分割线------------')
%% 开始预测
load predict_x.mat;
predict_y=zeros(size(predict_x,1),1);%初始化预测概率
predict=zeros(size(predict_x,1),1);%初始化预测结果
for i=1:size(predict_x,1)
    sum0=chef(1);
    for j=2:n
    sum0=sum0+chef(j)*predict_x(i,j-1);
    end
    predict_y(i)=sigmoid(sum0);
     if predict_y(i)>=0.5
        predict(i)=1;
    else
        predict(i)=0;
    end
end
disp('预测概率为：')
disp(predict_y)
disp('预测结果为')
disp(predict)

