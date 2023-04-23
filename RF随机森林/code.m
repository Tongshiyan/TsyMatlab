%% RF随机森林
clc;clear
treeNum = 15;%决策树数量
load data.mat%载入数据
%数据的前1：end-1列为特征
%数据end列为分类器结果
temp=randperm(size(data,1));%随机打乱已知样本数据
num=round(size(data,1)*0.8);%将前0.8*size(data,1)的数据作为训练集
dataTrain=data(temp(1:num),:);
dataTest=data(temp(num+1:end),:);
load predict_data.mat%载入预测数据的特征

[dataNum,featureNum]=size(dataTrain);
featureNum=featureNum-1;
[y,RF_model,featuremat]=RF(treeNum ,featureNum,dataNum ,dataTrain,dataTest);
fprintf('\n随机森林分类准确率为：%f %%\n',y*100);
% 预测与输出
RF_prection = RFprection(RF_model,featuremat,predict_data);
disp('随机森林分类结果为')
disp(RF_prection);