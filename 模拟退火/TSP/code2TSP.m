%% 模拟退火算法2.TSP旅行商问题
rng('shuffle')  % 控制随机数的生成，否则每次打开matlab得到的结果都一样
clear;clc
rng('shuffle')  % 控制随机数的生成，否则每次打开matlab得到的结果都一样
locatuion= ;%位置坐标，用于后续画散点图
n = size(location,1);%城市数目
figure  % 新建一个图形窗口
plot(location(:,1),location(:,2),'o');   % 画出城市的分布散点图
hold on 
distance = zeros(n);   % 初始化两个城市的距离矩阵全为0
for i = 2:n  
    for j = 1:i  
        location_i = location(i,:);   x_i =locaition_i(1);     y_i = location_i(2);  % 城市i的横坐标为x_i，纵坐标为y_i
        location_j = location(j,:);   x_j = location_j(1);     y_j = location_j(2);  % 城市j的横坐标为x_j，纵坐标为y_j
        distance(i,j) = sqrt((x_i-x_j)^2 + (y_i-y_j)^2);   % 计算城市i和j的距离
    end
end
d = distance+distance';   % 生成距离矩阵的对称的一面
%%参数初始化
t0= ;%初始温度
t=t0;%退火过程温度
max= ;%退出算法的最大迭代次数
lmax= ;%对每次的温度t下的迭代次数
a= ;%温度衰减系数

%%  随机生成一个初始解
path0 = randperm(n);  % 生成一个1-n的随机打乱的序列作为初始的路径
result0 = path(path0,d); % 调用path函数计算当前路径的距离

%% 定义一些保存中间过程的量，方便输出结果和画图
minresult = result0;     % 初始化找到的最佳的解对应的距离为result0
MINresult = zeros(max,1); % 记录每一次外层循环结束后找到的minresult (方便画图）
%%模拟退火过程
for wai=1:max%这里采用的是最大迭代次数退出模拟退火算法，外循环
    for nei=1:lmax%每个温度t迭代lmax遍，内循环
     path1 = newpath(path0);  % 调用newpath函数生成新的路径
        result1 = path(path1,d); % 计算新路径的距离
    %如果新解距离短，则直接把新解的值赋值给原来的解
        if result1 < result0    
            path0 = path1; % 更新当前路径为新路径
            result0 = result1; 
        else
            p = exp(-(result1 - result0)/t); % 根据Metropolis准则计算一个概率
            if rand(1) < p   % 生成一个随机数和这个概率比较，如果该随机数小于这个概率
                path0 = path1;  % 更新当前路径为新路径
                result0 = result1; 
            end
        end
  % 判断是否要更新找到的最佳的解
        if result0 < minresult  % 如果当前解更好，则对其进行更新
            minresult = result0;  % 更新最小的距离
            bestpath = path0;  % 更新找到的最短路径
        end
    end
    MINresult(i) = minresult; % 保存本轮外循环结束后找到的最小距离
    t= a*t;   % 温度下降       
end

disp('最佳的方案是：'); disp(mat2str(bestpath))
disp('此时最优值是：'); disp(minresult)
bestpath = [bestpath,bestpath(1)];   % 在最短路径的最后面加上一个元素，即第一个点（我们要生成一个封闭的图形）
n = n+1;  % 城市的个数加一个（紧随着上一步）
for i = 1:n-1 
    j = i+1;
    location_i = location(bestpath(i),:);   x_i = location_i(1);     y_i = location_i(2); 
    location_j = location(bestpath(j),:);   x_j = location_j(1);     y_j = location_j(2);
    plot([x_i,x_j],[y_i,y_j],'-b')    % 每两个点就作出一条线段，直到所有的城市都走完
%     pause(0.02)  % 暂停0.02s再画下一条线段
    hold on
end

%% 画出每次迭代后找到的最短路径的图形
figure
plot(1:max,Minresult,'b-');
xlabel('迭代次数');
ylabel('最短路径');
