%% 灰色关联分析
%题设分析结构变量（前三列）和产品性能（4-6）对插层率（7）的影响
clc;clear
load data.mat
[m,n]=size(data);
% 预处理去除量纲影响
ave=repmat(mean(data),m,1);
data=data./ave;
% 子序列和母序列的定义（子序列为分析自变量，母序列为分析因变量）
x1=data(:,1:3);
x2=data(:,4:6);
y=data(:,end);
y_rep=repmat(y,1,3);%将因变量的列数复制成跟自变量一样
absx1=abs(x1-y_rep);
absx2=abs(x2-y_rep);
%全局最小
min1=min(min(absx1));
min2=min(min(absx2));
%全局最大
max1=max(max(absx1));
max2=max(max(absx2));
ro = 0.5; %分辨系数取0.5
gamma1 =(min1+ro*max1)./(absx1+ro*max1); %计算子序列1结构变量中各个指标与母序列的关联系数
gamma2 =(min2+ro*max2)./(absx2+ro*max2); %计算子序列2产品性能中各个指标与母序列的关联系数
%输出
disp('结构变量对插层率的各个指标灰色关联度为')
disp(mean(gamma1))
disp('产品性能对插层率的各个指标灰色关联度为')
disp(mean(gamma2))