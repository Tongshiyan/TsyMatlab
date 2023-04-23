%% 人口预报模型
clc;
clear;
load x.mat %该程序规定x第一列为年份（自变量），第二列为人数（因变量）
%非线性最小二乘估计（以第一个数据作为初始条件）
population=x(:,2);
year=x(:,1);
t0=year(1);
x0=population(1);
fun=@(cs,td)cs(1)./(1+(cs(1)/x0-1)*exp(-cs(2)*(td-t0)));%cs(1)为人口最大环境容量cs（2）为增长率r
cs=lsqcurvefit(fun,rand(2,1),t(2:end-1),x0(2:end-1),zeros(2,1));%2：end-1的数据作为训练组
%lsqcurvefit(函数，随机初值，训练自变量，训练因变量，大小)用于非线性最小二乘估计
project_year=2022:2027;
project_population=fun(cs,project_year);%带入模型得出数据
disp([project_year '的人口预测数据为' project_population])
disp('最大人口容量population_max为')
disp(cs(1))
%模型检验
p0=fun(cs,year(end));
disp("该模型的离差平方和(SST)为")
disp(p0)

%画图
grid on
hold on
plot(year,population,'b*',year,fun(cs,year),'g-',project_year,project_populaton,'r-')
legend(['ever','future']);