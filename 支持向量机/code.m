%% 支持向量机SVM 分类模型之一
clc;clear
load data.mat  %得到数据
[m,n]=size(data); %得到行数和列数
temp=randperm(m);%打乱数据
num=round(m*0.8);%训练集的数量
train_data=data(temp(1:num),1:n-1);%训练集自变量数据
train_label=data(temp(1:num),n);%训练集标签
test_data=data(temp(num+1:end),1:n-1);%测试集自变量数据
test_label=data(temp(num+1:end),n);%测试集标签(真实标签)
load predict_x.mat
%load svm.mat
%% 向量机训练
%svm=fitcsvm(train_data,train_label);
svm=fitcecoc(train_data,train_label);%训练支持向量机
%% 模型评价
test_label_predict=predict(svm,test_data);%SVM预测出来的标签
disp('支持向量机SVM的预测准确率为')
disp([num2str((sum(test_label_predict==test_label)/length(test_label))*100) '%'])
%% 分类
disp('-------------------------分界线------------------------')
disp('开始分类未分类数据')
disp('分类结果')
disp(predict(svm,predict_x))