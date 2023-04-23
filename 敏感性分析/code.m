%% sobol 敏感性分析
%作用于模型输入对模型输出的影响程度分析（当输入参数不好估计时）
clc;clear

%% 初始化
dimension=3;%参数数量
m=dimension*2;
n=40;%采样点个数
low=[0 0 0];%每个参数的下限
high=[1 1 1];%每个参数的上限
%产生各水平参数
low=[low,low];
high=[high,high];
p=sobolset(m);%sobol采样
r=[];
for i=1:n %开始采样
    r_0=p(i,:);
    r_0=low+r_0.*(high-low);
    r=[r;r_0];
end
 plot(r(:,1),'b*');%画出采样图
 %将采样的点分成ab两份
 a=r(:,1:dimension);%每行一组数据，每列代表参数
 b=r(:,dimension+1:end);
 % 生成矩阵
 ab=zeros(n,dimension,dimension);%初始化，生成三个n*dimension矩阵，最后一个dimension可以理解为是标号
 for i=1:dimension%对第i个标号的矩阵，将b的第i列替换a的第i列，总共替换i次
     temp=a;
     temp(:,i)=b(:,i);
     ab(1:n,1:dimension,i)=temp;
 end
 %% 求解参数
 result_a=zeros(n,1);
 result_b=zeros(n,1);
 result_ab=zeros(n,dimension);
 for i=1:n
     result_a(i)=solvefunction(a(i,:));
     result_b(i)=solvefunction(b(i,:));
     for j=1:dimension
         result_ab(i,j)=solvefunction(ab(i,:,j));
     end
 end
 %一阶影响指数公式
 var_x=zeros(dimension,1);
 s=zeros(dimension,1);
 result_var=var([result_a;result_b],1);
 for i=1:dimension
     for j=1:n
         var_x(i)=var_x(i)+result_b(j)*(result_ab(j,i)-result_a(j));
     end
     var_x(i)=1/n*var_x(i);
     s(i)=var_x(i)/result_var;
 end
 
 %% 总效益系数的计算
 E=zeros(dimension,1);
 ST=zeros(dimension,1);
 for i=1:dimension
     for j=1:n
         E(i)=E(i)+(result_a(j)-result_ab(j,i))^2;
     end
     E(i)=1/(2*n)*E(i);
     ST(i)=E(i)/result_var;
 end
 %% 输出

 disp('一阶影响指数S：')
 disp(s)
 disp('全局影响指数ST:')
 disp(ST)
 