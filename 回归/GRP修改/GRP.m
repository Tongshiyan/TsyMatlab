%% 高斯过程回归GRP
%r表示目标拟合优度
%i表示第几个GRP模型
function [y_predict]=GRP(data,x_predict)

x=data(:,1);%自变量 6个输入
y=data(:,end);%因变量数据集
temp=randperm(size(x,1));%随机打乱已知样本数据
num=round(size(x,1)*0.8);
train_x=x(temp(1:num),:);%取m*0.8个训练样本
train_y=y(temp(1:num),:);%训练样本的输出
test_x=x(temp(num+1:end),:);%测试样本
test_y=y(temp(num+1:end),:);%测试样本输出

%归一化去量纲
[train_x0,P1]=mapminmax(train_x',0,1);
train_x0=train_x0';
[train_y0,P2]=mapminmax(train_y',0,1);
train_y0=train_y0';
test_x0=mapminmax('apply',test_x',P1)';

test_y0=mapminmax('apply',test_y',P2)';
    %模型训练
    yi=train_y0(:,1);
    gprMdl = fitrgp(train_x0,yi,'Basis','pureQuadratic',...
      'FitMethod','exact','PredictMethod','exact');
    %测试集检验
    test_predict=predict(gprMdl,test_x0); 
    disp(MSEloss(test_y0,test_predict));
    %输出预测值
    out=predict(gprMdl,mapminmax('apply',x_predict',P1)');%2*1
    out1=mapminmax('reverse',out',P2)';%2*4
    y_predict=out1(:,1);%第i列数据
    img(data(:,1),data(:,2),y_predict,P1,P2,gprMdl);
end
