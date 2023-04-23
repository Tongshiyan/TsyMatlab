%% 模拟退火解决书店买书类问题
clc;clear

rng('shuffle')  % 控制随机数的生成
load jg.mat;
load yf.mat;%载入数据(价格矩阵和运费矩阵）
[x0,y0]=size(jg);%x0为书店数量，y0为需要的书本数量
%% 参数初始化
t0=100;%初始温度
t=t0;%温度
max =600;%最大迭代次数
lmax=500;%每个温度对应的迭代次数
a=0.95;%温度衰减系数
%% 产生初始解
way0 = randi([1, x0],1,y0); % 在1-x0这些整数中随机抽取一个1*y0的向量，表示这y0本书分别在哪家书店购买
money0 = money(way0,yf,jg,y0); % 调用money函数计算这个方案的花费
%% 方便输出结果和画图
min_money = money0;     % 初始化找到的最佳的解对应的花费为money0
MONEY = zeros(max,1); % 记录每一次外层循环结束后找到的min_money (方便画图）

%% 模拟退火过程
for i = 1 : max  % 外循环, 我这里采用的是指定最大迭代次数
    for j = 1 : lmax  %  内循环，在每个温度下开始迭代
        way1 = newway(way0,x0,y0);  % 调用newway函数生成新的方案
        money1 = money(way1,yf,jg,y0); % 计算新方案的花费
        if money1 < money0    % 如果新方案的花费小于当前方案的花费
            way0 = way1; % 更新当前方案为新方案
            money0 = money1;
        else
            p = exp(-(money1 - money0)/t); % 根据Metropolis准则计算一个概率
            if rand(1) < p   % 生成一个随机数和这个概率比较，如果该随机数小于这个概率
                way0 = way1;
                money0 = money1;
            end
        end
        % 判断是否要更新找到的最佳的解
        if money0 < min_money  % 如果当前解更好，则对其进行更新
            min_money = money0;  % 更新最小的花费
            bestway = way0;  % 更新找到的最佳方案
        end
    end
    MONEY(i) = min_money; % 保存本轮外循环结束后找到的最小花费
    t = a*t;   % 温度下降
end

disp('最佳的方案是：');disp(mat2str(bestway))
disp('此时最优值是：'); disp(min_money)
%% 画出每次迭代后找到的最佳方案的图形
figure
plot(1:max,MONEY,'b-');
xlabel('迭代次数');
ylabel('最小花费');