%% 遗传算法 GA 采用浮点数编码
%得到最好的a值
clc;clear
load data.mat;


%% 初始化参数
n=500;%种群数目
ger=1000;%迭代次数，总共有多少代
var=0.2;%变异概率
acr=0.4;%交叉概率 

n_chr=4;%染色体个数，自变量个数
%length_chr=10;%精度，二进制编码长度，染色体内基因个数 （这里不需要）
range_chr=[0 1];%自变量的取值范围***

best_fitness=zeros(1,ger);%存放每一代的最优适应度
ave_fitness=zeros(1,ger);%存放每一代的平均适应度

%% 初始化第一代solvevar(chr,var,n,n_chr,range_chr,i,ger)
chr=ys(n,n_chr);%存放个体的染色体
fitness=solvefit(chr,n,data);%计算适应度
best_fitness(1)=max(fitness); %将当前最优存入矩阵当中
ave_fitness(1)=mean(fitness);%将当前平均适应度存入矩阵当中
best_chr=findbest_chr(chr,fitness,n_chr);%存放最优染色体和适应度前n_chr个是染色体，n_chr+1是适应度
%% 开始遗传
for i=2:ger
    chr=solveacr(chr,acr,n,n_chr);%交叉过程
    chr=solvevar(chr,var,n,n_chr,range_chr,i,ger);%变异处理
    fitness=solvefit(chr,n,data);%计算适应度
    best=findbest_chr(chr,fitness,n_chr);
    if best_chr(end)<best(end)
       best_chr=findbest_chr(chr,fitness,n_chr);%存放当前的最优染色体和适应度
    end
    %替换劣等解
    [chr,fitness]=solveworse(chr,best_chr,fitness);
    best_fitness(i)=max(fitness); %将当前最优存入矩阵当中
    ave_fitness(i)=mean(fitness);%将当前平均适应度存入矩阵当中
%     acr=acr*0.95;%自适应交叉算子
%     var=var*0.95;%自适应变异算子
end


%% 画出适应度图像
figure;
plot(1:ger,ave_fitness','y','linewidth',2.5)
hold on
plot(1:ger,best_fitness','r','linewidth',3);
grid on;
title('投影寻踪综合评价模型适应度图像')
legend('平均适应度','最优适应度');
xlabel('迭代次数')
ylabel('适应度')
disp(['最优染色体：' 'a=' num2str(best_chr(1:end-1))])
disp(['最优适应度：',num2str(best_chr(end))])
disp('投影寻踪综合评价的评分为')
disp((best_chr(1:end-1)*data')')
