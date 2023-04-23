%% Bias+Variance  计算误差 需要输入训练集和测试集所有的值】
%train_real 训练集真实值
%train_hat 训练集拟合值
%test_real 测试集真实值
%test_hat 测试集拟合值
%用的是测试集和训练集的MSE代数和
function result=BV(train_real,train_hat,test_real,test_hat)
Bias=sum((train_real-train_hat).^2)/max(size(train_hat));%默认样本数多于自变量个数
Variance=sum((test_real-test_hat).^2)/max(size(test_hat));

result=sum(Bias)+sum(Variance);
end