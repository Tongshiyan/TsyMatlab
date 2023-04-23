%% 一元非线性回归模型
clc;clear
%% 绘制散点图并分析走势
load data.mat;
x=data(:,2);
y=data(:,3);
figure;
plot(x,y,'ko');%绘制散点图
xlabel('周目');
ylabel('供货偏差');%具体的标签需要自己改
%%  根据散点图的走势，确定回归方程的具体形式，对参数个数进行设定和设定初始值
%建立一元非线性回归方程
fun=@(beta,x)beta(1)./(1-beta(2)*x);%根据散点图趋势建立方程f(x)=b1./(1-b2*x),方程形式并不唯一。*****
beta0=[120,0.008];%beta0为b1,b2的初始值。
opt=statset;%创建结构体变量类
opt.Robust='on';%开启回归稳健性方法
way1=NonLinearModel.fit(x,y,fun,beta0,'Options',opt);
%%  调用NonLinearModel的fit方法进行模型拟合
newx=linspace(20,40,50)';
ynew=way1.predict(newx);%进行预测
figure;
plot(x,y,'ko');
hold on;
plot(newx,ynew,'linewidth',2);
xlabel('周目');
ylabel('供货偏差');
legend('原始数据散点','非线性回归曲线');
%% 模型改进，去除异常值的操作；
Res2=way1.Residuals;
Res_Stu2=Res2.Studentized;
id2=find(abs(Res_Stu2)>2);
%去除异常值重新构建回归模型
way2=NonLinearModel.fit(x,y,fun,beta0,'Exclude',id2,'options',opt);
%% 画出新图
newx=linspace(20,40,50)';
y1=way1.predict(newx);
y2=way2.predict(newx);
figure;
plot(x,y,'ko');
hold on;
plot(newx,y1,'r--','linewidth',2);
plot(newx,y2,'b.','linewidth',2);
xlabel('周目');
ylabel('供货偏差');
legend('原始数据散点','回归曲线','去除异常值后的回归曲线');
%% 进行残差分析，验证模型。

%回归诊断
figure;
subplot(1,2,1);
way1.plotResiduals('histogram');
title('(a)残差直方图');
xlabel('残差r');
ylabel('f(r)');
subplot(1,2,2);
way1.plotResiduals('probability');
title('(b)残差正态概率图');
xlabel('残差');
ylabel('概率');


