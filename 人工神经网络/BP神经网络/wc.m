%% 拟合优度计算函数
%R²是指拟合优度,是回归直线对观测值的拟合程度。
function R2=wc(reverse_out,test_y)
 R2=1-(sum((test_y-reverse_out).^2))/(sum((test_y-mean(test_y)).^2));
end