function [fitness,dec]=solvefunction(bin,range_len)
%% 目标函数
% 输入     bin：二进制编码
%   range_len：各变量的二进制位数
% 输出     fitness：目标值
%          dec：十进制数
global range;
%% 二进制转十进制
dec=bin2decfunction(bin,range_len,range);
%% 计算适应度-函数值
fitness=sin(4*pi*dec(1))*dec(1)+sin(20*pi*dec(2))*dec(2);
