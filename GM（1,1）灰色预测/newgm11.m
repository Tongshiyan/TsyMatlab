function [out1]=newgm11(in1,in2)
out1 = zeros(1,in2);
for i = 1 : in2 
        out1(i) = gm11(in1, 1);  % 将预测一期的结果保存到out1中
        in1 = [in1, out1(i)];  % 更新in1向量
    end
end