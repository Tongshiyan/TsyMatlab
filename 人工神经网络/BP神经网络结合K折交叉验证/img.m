%% 画图函数 
%real表示真实值，hat表示拟合值
function []=img(real,hat)
[m,n]=size(real);
for i=1:n
    figure
    plot(1:m,real(:,i),'b-o',1:m,hat(:,i),'r--*')
    xlabel('样本序号')
    ylabel('样本值')
    title(['第' num2str(i) '个自变量预测值和真实值对比图'])
    legend('真实值','预测值');
end
end