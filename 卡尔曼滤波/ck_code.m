% Kalman filter example 
%% 系统描述：
% 1.硬币直径真实值为50mm；
% 2.开始时，硬币直径的估计为40mm，估计误差为5mm；
% 3.尺子的测量误差为3mm；
%% 变量初始化
close all;
clc;clear
% intial parameters
% 计算连续n_iter次数
n_iter = 200;
% size of array. n_iter行，1列
sz = [n_iter, 1];
% 硬币直径的真实值
x = 50;
% 过程方差，反应连续两个次直径方差。更改查看效果
Q = 0;
% 测量方差，反应尺子的测量精度。更改查看效果
R = 3;
% z是尺子的测量结果，在真实值的基础上加上了方差为3的高斯噪声。
z = x + sqrt(R)*randn(sz);
%% 对数组进行初始化
% 对直径的后验估计。即在k次，结合尺子当前测量值与k-1次先验估计，得到的最终估计值
xhat = zeros(sz); 
% 后验估计的方差
P = zeros(sz); 
% 直径的先验估计。即在k-1次，对k时刻直径做出的估计
xhatminus = zeros(sz);
% 先验估计的方差
Pminus = zeros(sz);
% 卡尔曼增益，反应了尺子测量结果与过程模型（即当前时刻与下一次直径相同这一模型）的可信程度
K = zeros(sz); 
% intial guesses
xhat(1) = 40; %直径初始估计值为40mm
P(1) =10; % 误差方差为10
%% kalman 方程
for k = 2:n_iter
    % 时间更新（预测） 
    % 用上一次的最优估计值来作为对本次的直径的预测
    xhatminus(k) = xhat(k-1);
    % 预测的方差为上一次直径最优估计值的方差与过程方差之和
    Pminus(k) = P(k-1)+Q;
    
    % 测量更新（校正）
    % 计算卡尔曼增益
    K(k) = Pminus(k)/( Pminus(k)+R );
    % 结合当前时刻尺子的测量值，对上一次的预测进行校正，得到校正后的最优估计。该估计具有最小均方差
    xhat(k) = xhatminus(k)+K(k)*(z(k)-xhatminus(k));
    % 计算最终估计值的方差
    P(k) = (1-K(k))*Pminus(k);
end
%% 作图
FontSize = 14;
LineWidth = 3; % 线宽
figure();
plot(z,'r-*'); %画出尺子的测量值
hold on;
plot(xhat,'b-','LineWidth',LineWidth) %画出最优估计值
hold on;
plot(x*ones(sz),'g-','LineWidth',LineWidth); %画出真实值
grid on;

legend('尺子的测量结果', '后验估计', '真实值');
title('kalman 滤波','fontsize',FontSize);
xl = xlabel('次数');
yl = ylabel('直径（mm）');
set(xl,'fontsize',FontSize);
set(yl,'fontsize',FontSize);
hold off;
set(gca,'FontSize',FontSize);% gca:坐标轴序号

figure();
valid_iter = 2:n_iter; % Pminus not valid at step 1
% 画出最优估计值的方差
plot(valid_iter,P(valid_iter),'LineWidth',LineWidth);
grid on;

legend('后验估计的误差估计');
title('最优估计值的方差','fontsize',FontSize);
xl = xlabel('次数');
yl = ylabel('次数^2');
set(xl,'fontsize',FontSize);
set(yl,'fontsize',FontSize);
set(gca,'FontSize',FontSize);
