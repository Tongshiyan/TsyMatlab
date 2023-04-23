%% 因子分析
clc;clear
load data.mat
traindata=data(:,2:end);
[lambda,psi,T,stats] = factoran(traindata,4);
disp('因子荷载矩阵lambda:')
disp(lambda)
disp('特殊方差矩阵的估计psi:')
disp(psi)
disp('模型检验信息stats:')
disp(stats)
Contribut = 100*sum(lambda.^2)/8;
CumCont = cumsum(Contribut); %计算累积贡献率
disp('贡献率Contribut:')
disp(Contribut)
disp('累计贡献率CumCont:')
disp(CumCont)
%
Fc=traindata*lambda;%因子矩阵
Fc1=Fc(:,2:end)-Fc(:,1);
Fc1=(Fc1-min(Fc1))./(max(Fc1)-min(Fc1));%归一化
Q=sum(abs(Fc1-mean(Fc1)),2);
range=mean(Q)+std(Q)*1.645;%单边检验范围
