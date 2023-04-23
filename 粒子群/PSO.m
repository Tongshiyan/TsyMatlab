%% 粒子群PSO算法
clc;clear
%% 初始化参数
n=50;%初始的种群个数
d=1;%变量个数
lim=[];%参数的限制
vlim=[];%“飞行”速度的限制
%这些限制参数第一行为上界第二行为下界
w=0.8;%惯性权重
c1=0.5;%自我学习因子
c2=0.5;%社会学习因子
max=20;%最大迭代次数
%figure(1); ezplot(fun(),[ min,0.01 ,max]);%画图需要自己输入fun目标函数，min参数下界，max参数上界,变量多于2就不画图
x0=lim()+(lim()-lim())*rand(n,d);%初始化种群位置
v0=rand(n,d);%初始化种群速度
xmax=x0;%xmax记录个体最佳位置，当前为初始化
ymax=zeros(1,d);%ymax记录种群的最佳位置既优化问题的解
fxm=ones(n,1)*inf;%记录每个个体的最大适应度
fym=inf;%记录种群的最大适应度
% hold on
% plot(xmax,fun(xmax),'ro');title("初始状态图");
% figure(2) %这里也是如果变量比2大就不画图

%% PSO过程
for iter = 1:max
    fx=fun(x0);
    for i=1:n
    if fx(i)<fxm(i)
        fxm(i)=fx(i);%更新个体适应度
        xmax(i,:)=x0(i,:);%更新个体最佳位置
    end
     end
    if min(fxm)<fym
        [fym,nmin]=min(fxm);%更新种群最佳适应度(目标函数值）
        ymax=fun(x0(nmin,:));%更新最优解
    end
    v0=v0*w+c1*rand*(xmax-x0)+c2*rand*(repmat(ymax,n,d)-x0);%更新速度
    %边界速度处理
     v0(v0>vlim(1,:))= vlim(1,:);
     v0(v0<vlim(2,:))= vlim(2,:);
     %边界速度处理
     x0=x0+v0;
     x0(x0>xlim(1,:))=xlim(1,:);
     x0(x0<xlim(2,:))=xlim(2,:);
    
end
%画图最终位置
x1=0:0.01:xlim(1,:);
figure(3); plot(x1,fun(x1),'b-',x0,fun(x0),'ro');title("最终状态");
disp(["最优解：",num2str(ymax)])
disp(["变量值：",mat2str(xmax(randi(n),:))])
    