%% 量子遗传优化算法(QGA)
clc;clear
%% 参数设置
ger=200;%遗传的代数目
n=40;%种群数目
n_chr=2;%染色体数目
global range
range=[-3.0 12.1;4.1 5.8];   % 函数自变量的范围既染色体取值范围
range_len=[20 20];%每个二进制编码的长度
ger_fitness=zeros(1,ger);%每一代的最佳适应度
best=struct('fitness',0,'dec',[],'bin',[],'chr',[]);%记录最佳个体的适应度值、十进制值、二进制编码、量子比特编码
%           适应度     十进制值  二进制码    量子比特编码
%初始化种群
chr=Pop(n*2,sum(range_len));
%得到二进制编码
bin=coll(chr);
%计算初始种群的适应度和十进制编码
[fitness,dec]=solvefitness(bin,range_len);
%% 记录最佳个体到best
[best.fitness,bestid]=max(fitness);     % 找出最大值
best.bin=bin(bestid,:);
best.chr=chr(2*bestid-1:2*bestid,:);
best.dec=dec(bestid,:);
ger_fitness(1)=best.fitness;
fprintf('第%d代遗传开始\n',1)

%% 开始遗传
for i=2:ger
    fprintf('第%d代遗传开始\n',i);
    bin=coll(chr);
    [fitness,dec]=solvefitness(bin,range_len);
    chr=gate(chr,fitness,best,bin);%量子旋转门
    [new_fitness,newfitness_id]=max(fitness);
    %更新最优适应度下的最优个体
    if new_fitness>best.fitness
        best.fitness=new_fitness;
        best.bin=bin(newfitness_id,:);
        best.chr=chr(2*newfitness_id-1:2*newfitness_id,:);
        best.dec=dec(newfitness_id,:);
    end
    ger_fitness(i)=best.fitness;
end
disp('遗传结束')
%% 画进化曲线
figure(1)
plot(1:ger,ger_fitness,'b-','LineWidth',1.5)
title('量子遗传优化算法');
xlabel('进化代数');
ylabel('每代的最佳适应度');

%% 显示优化结果
disp(['最优解：',num2str(best.dec)])
disp(['最佳适应度:',num2str(best.fitness)]);
figure(2)
x=-3:0.1:12.1;
y=4.1:0.1:5.8;
[x,y]=meshgrid(x,y);
z=x.*sin(4*pi*x)+y.*sin(20*pi*y);
surf(x,y,z)