function [out1]=xcdxgm11(in1,in2)
out1= zeros(1,in2);  % 初始化用来保存预测值的向量
    for i = 1 : in2
        out1(i) = gm11(in1, 1);  % 将预测一期的结果保存到result中
        in1= [in1(2:end), out1(i)];  % 更新x0向量，此时x0多了新的预测信息，并且删除了最开始的那个向量
    end
end
