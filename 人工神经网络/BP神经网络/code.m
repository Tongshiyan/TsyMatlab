%% BP神经网络 
clc;clear
load x.mat;%x是已知数据 
load y.mat;%y是因变量
load predict_x.mat;%需要预测自变量
    

%% 初始化
temp=randperm(size(x,1));%随机打乱已知样本数据
num=round(size(x,1)*0.8);
train_x=x(temp(1:num),:)';%取40个训练样本
train_y=y(temp(1:num),:)';%40个训练样本的输出
test_x=x(temp(num+1:end),:)';%测试集合样本
test_y=y(temp(num+1:end),:)';%测试集合的输出
[m,n]=size(test_x);
%% 数据归一化
[train_x0,train_x1]=mapminmax(train_x,0,1);%将样本数据限制到【0，1】中

test_x0=mapminmax('apply',test_x,train_x1);
[train_y0,train_y1]=mapminmax(train_y,0,1);
predict_x0=mapminmax('apply',predict_x',train_x1);
corr_out=zeros(6,size(train_y0,1));
for j=5:10
%% BP神经网络
net = newff(train_x0,train_y0,j,{ 'logsig' 'purelin' },'traingda');%10为隐藏层神经元的层数
net.trainParam.epochs = 2000;   %迭代次数
net.trainParam.goal = 1e-7;      %mse均方根误差小于这个值训练结束
net.trainParam.lr = 0.01;         %学习率


%开始训练
net = train(net,train_x0,train_y0);
disp('训练完成')
%仿真
out=sim(net,test_x0);%sim仿真函数根据训练结果给出值
reverse_out= mapminmax('reverse',out,train_y1);
disp('拟合完成')

%% 效果测评
p=reverse_out';
q=test_y';
for k=1:size(p,2)%因变量个数
    t=corr(p(:,k),q(:,k),'type','Spearman');
    corr_out(j-4,k)=t;
end
end
% %% 效果测评
% %  er=abs(reverse_out-test_y)./test_y;%相对误差
% R2=wc(reverse_out,test_y);
% %R2为决定系数
%     disp('真实值')
%     disp(test_y)
%     disp('拟合值')
%     disp(reverse_out)
% %     disp('相对误差')
% %     disp(er)
% disp('拟合优度R²=')
% disp(R2);
%% 绘制图像
reverse_out=round(reverse_out);
reverse_out(reverse_out<0)=0;
    
for i =1:size(reverse_out,1)
figure
plot(1:n,test_y(i,:),'b*',1:n,reverse_out(i,:),'rh')
legend('True','Predict')
xlabel('sample')
ylabel('Times')
if i==1
    title('1 try')
elseif i==7
    title('7 or more tries (X)')
else
    title([num2str(i) 'tries'])
end
end

predict_y=sim(net,predict_x0);%predict_x转置
predict_y=mapminmax('reverse',predict_y,train_y1);
predict_y=round(predict_y)';
disp('预测值')
disp(predict_y)

% hold on
% plot(n+1:n+size(predict_x,1),predict_y,'g-*')
