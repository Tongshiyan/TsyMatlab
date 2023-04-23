%% 拟合优度计算函数
%R²是指调整后的拟合优度,是回归直线对观测值的拟合程度。

function R2=wc(reverse_out,test_y,k)
R2=1-(sum((reverse_out-test_y).^2)/(size(reverse_out,1)-k-1))/(sum((mean(test_y)-test_y).^2)/(size(reverse_out,1)-1));
end