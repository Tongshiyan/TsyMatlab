%% BP神经网络 结合K折交叉验证
clc;clear
       
load x.mat;%x是已知数据 
load y.mat;%y是因变量
load predict_x.mat;%需要预测自变量
while 1

k=5;%交叉集个数
k_net=cell(k,4);%第一列存放每个网络模型,第二列存放每个网络对应的Bias+Variance,第三列存放归一化x返回，第四列存放归一化y返回
data=zeros(size(x,1),size(x,2)+size(y,2));
data(:,1:size(x,2))=x;
data(:,size(x,2)+1:end)=y;
k_data=K(data,k);   
for i=1:k
%% 初始化
test_x=(k_data{i}(:,1:size(x,2)))';
test_y=(k_data{i}(:,1+size(x,2):end))';
train_x=[];
train_y=[];
for j=1:k
    if i~=j
        train_x=cat(1,train_x,k_data{j}(:,1:size(x,2)));
        train_y=cat(1,train_y,k_data{j}(:,1+size(x,2):end));
    end
end
train_x=train_x';
train_y=train_y';
[m,n]=size(test_x);
%% 数据归一化
[train_x0,train_x1]=mapminmax(train_x,0,1);%将样本数据限制到【0，1】中
test_x0=mapminmax('apply',test_x,train_x1);
[train_y0,train_y1]=mapminmax(train_y,0,1);

%% BP神经网络
net = newff(train_x0,train_y0,5,{ 'logsig' 'purelin' },'traingdx');%10为隐藏层神经元的层数

net.trainParam.epochs = 1000;   %迭代次数
net.trainParam.goal = 1e-7;      %mse均方根误差小于这个值训练结束
net.trainParam.lr = 0.01;         %学习率

%开始训练
net = train(net,train_x0,train_y0);
disp('训练完成')
%仿真
out_train=sim(net,train_x0);
reverse_train= mapminmax('reverse',out_train,train_y1);
out=sim(net,test_x0);%sim仿真函数根据训练结果给出值
reverse_out= mapminmax('reverse',out,train_y1);
disp('拟合完成')

%% 效果测评与记录
k_net{i,1}=net;
k_net{i,2}=BV(train_y',reverse_train',test_y,reverse_out);
k_net{i,3}=train_x1;
k_net{i,4}=train_y1;
end
%% 结果输出
best=[1,k_net{1,2}];%记录最好模型的标号
for i=2:k
    if k_net{i,2}<best(2)
        best(2)=k_net{i,2};
        best(1)=i;
    end
end
% 训练较好的模型 控制误差
if best(2)<20
    break;
end
end
%% 画图
x_hat=mapminmax('apply',x',k_net{best(1),3});
y_hat=sim(net,x_hat);
y_hat= (mapminmax('reverse',y_hat,k_net{best(1),4}))';
img(y,y_hat)
%% 结果输出
disp(['因为第' num2str(best(1)) '个网络模型的 Bias+Variance = ' num2str((best(2))) '最小'])
disp(['选取第' num2str(best(1)) '个网络模型'])

predict_x0=mapminmax('apply',predict_x',k_net{best(1),3});        
predict_y=sim(k_net{best(1),1},predict_x0);%predict_x转置
predict_y=mapminmax('reverse',predict_y,k_net{best(1),4});
predict_y=predict_y';
disp('预测值')
disp(predict_y)
