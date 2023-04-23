%% 适应度函数
% 输入  bin：二进制编码
%     range_len：各变量的二进制位数
% 输出 fitness：适应度
%            dec：十进制数（待优化参数）
function [fitness,dec]=solvefitness(bin,range_len)
sizepop=size(bin,1);
fitness=zeros(1,sizepop);
num=size(range_len,2);
dec=zeros(sizepop,num);
for i=1:sizepop
    [fitness(i),dec(i,:)]=solvefunction(bin(i,:),range_len); %solvefunction题目所设目标函数
end
