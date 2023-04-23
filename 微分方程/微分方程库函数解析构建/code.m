%% MATLAB微分方程常用库函数的构建
%符号解
% syms y(x)_定义符号变量表明y是x的函数
% [y1,y2...,yn]=desolve(符号微分方程或微分方程组，初值条件或者边界条件，可选的成对参数)
% diff(y,n)符号变量y的n阶偏导
%simplify(f)对符号解进行化简

%初值问题的MATLAB数值解
%RK方法解微分方程（ode23，ode45，ode113）
%[t,y]=solver('F',tspan,y0）
%其中solver为（ode23，ode45，ode113）其中之一
%'F'为微分方程组，tspan是[t0,tfinal]求解区间，y0是初值返回值可以是一个值，返回一个值是结构体数组可以通过deval计算任意一点函数值
clc;clear
yx=@(x,y) -2*y+2*x^2+2*x;
[x,y]=ode45(yx,[0.5,1],1);
sol=ode45(yx,[0.5,1],1);
y2=deval(sol,x);
check=[y,y2'];

%边界问题的MATLAB数值解
%sol=bvp4c(@odefun,@bcfun,solinit,options,p1,p2,...)
%odefun格式 yprime=odefun(x,y,p1,p2,...)
%bcfung格式 res=bcfun(ya,yb,p1,p2,...)
%详见《数学建模算法与应用》