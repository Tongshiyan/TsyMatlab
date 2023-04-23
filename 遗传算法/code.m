%% 遗传算法 GA 采用浮点数编码
clc;clear
best1=-inf;
for t=1:100 %SB算法得到较好的最优解
%% 初始化参数
n=200;%种群数目
ger=1000;%迭代次数，总共有多少代
var=0.2;%变异概率
acr=0.4;%交叉概率 

n_chr=2;%染色体个数，自变量个数
length_chr=10;%精度，二进制编码长度，染色体内基因个数 （这里不需要）
range_chr=[-10 10;-10 10];%自变量的取值范围***

best_fitness=zeros(1,ger);%存放每一代的最优适应度
ave_fitness=zeros(1,ger);%存放每一代的平均适应度

%% 初始化第一代solvevar(chr,var,n,n_chr,range_chr,i,ger)
chr=rand(n,n_chr);%存放个体的染色体
for i=1:n_chr
    chr(:,i)=chr(:,i)*(range_chr(i,2)-range_chr(i,1))+range_chr(i,1);%映射到范围***
end
fitness=solvefit(chr,n,n_chr);%计算适应度
best_fitness(1)=max(fitness); %将当前最优存入矩阵当中
ave_fitness(1)=mean(fitness);%将当前平均适应度存入矩阵当中
best_chr=findbest_chr(chr,fitness,n_chr);%存放最优染色体和适应度前n_chr个是染色体，n_chr+1是适应度
%% 开始遗传
for i=2:ger
    chr=solveacr(chr,acr,n,n_chr);%交叉过程
    chr=solvevar(chr,var,n,n_chr,range_chr,i,ger);%变异处理
    fitness=solvefit(chr,n,n_chr);%计算适应度
    best=findbest_chr(chr,fitness,n_chr);
    if best_chr(end)<best(end)
       best_chr=findbest_chr(chr,fitness,n_chr);%存放当前的最优染色体和适应度
    end
    %替换劣等解
    [chr,fitness]=solveworse(chr,best_chr,fitness);
    best_fitness(i)=max(fitness); %将当前最优存入矩阵当中
    ave_fitness(i)=mean(fitness);%将当前平均适应度存入矩阵当中
    acr=acr*0.95;%自适应交叉算子
    var=var*0.95;%自适应变异算子
end
if best1<best_chr(end)
    best1=best_chr(end);
    best2=best_chr(1:end-1);
end
end
%% 画出适应度图像
figure;
plot(1:ger,ave_fitness','y','linewidth',2.5)
hold on
plot(1:ger,best_fitness','r','linewidth',3);
grid on;
legend('平均适应度','最优适应度');
disp(['最优染色体：' num2str(best2)])
disp(['最优适应度：',num2str(best1)])
  
