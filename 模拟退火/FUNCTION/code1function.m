%% 模拟退火算法1.函数极值问题
clear;clc

%%参数初始化
n=2 ;%变量个数
t0=100 ;%初始温度
t=t0;%退火过程温度
max=600 ;%退出算法的最大迭代次数
lmax=500 ;%对每次的温度t下的迭代次数
a=0.95 ;%温度衰减系数
xm=[9,9] ;%x定义域的上界
xi= [1,3];%x定义域的下界

%%随机生成初始解
x0 = zeros(1:n);
for i=1:n
    x0(i)=xi(i)+(xm(i)-xi(i))*rand(1);
end
y0=fun(x0); %fun为自定的函数（目标函数）

%% 定义一些保存中间过程的量，方便输出结果和画图
ym=y0;
maxy=zeros(max,n);
%%模拟退火过程
for wai=1:max%这里采用的是最大迭代次数退出模拟退火算法，外循环
    for nei=1:lmax%每个温度t迭代lmax遍，内循环
    y=randn(1,n);%生成对应函数变量的N（0，1）随机数
    z=y/sqrt(sum(y.^2));%产生新解，按照原有函数规则。这里必须根据具体的规则来拟定***
    xnew=x0+z*t;%根据具体的规则来确定新的解***
    %对这个新解进行调整保证它在定义域范围内
   for j=1:n
    if xnew(j)<xi(j)
    r= rand(1);
    xnew(j)=r*xi(j)+(1-r)*x0(j);
    elseif xnew(j)>xm(j)
    r= rand(1);
    xnew(j)=r*xi(j)+(1-r)*x0(j);
    end
   end
 x1= xnew;%将新解赋值给x1
 y1=fun(xnew);%得到新解的目标函数值
  if y1>y0%这里是求目标函数在定义域内的最大值**
   x0=x1;%将原解替换为新解
   y0=y1;
  else
   p=exp(-(y0-y1)/t);%根据Metropolis准则生成一个概率
   if rand(1)<p%对退火的接受做一个判断
      x0=x1;
      y0=y1;
   end
end
%判断是否需要更新找到的最佳解
 if y0>maxy
  besty=y0;
  bestx=x0;
end
end
maxy(i,:)=besty;%保存每次循环结束后最好的值
t=a*t;%温度下降
end
disp('最佳的位置：');disp(bestx)
disp('此时最优值是：'); disp(besty)
%%画图的话后续再添加，如果是多元函数最好不画图了