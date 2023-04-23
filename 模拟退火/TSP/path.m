function  out =  path(in1,in2)
% 输入：in1:路径（1至n的一个序列），in2：距离矩阵
    n = length(in1);
    out = 0; % 初始化该路径走的距离为0
    for i = 1:n-1  
        out = in2(in1(i),in1(i+1)) + out;  % 按照这个序列不断的更新走过的路程这个值
    end   
    out = in2(in1(1),in1(n)) + out;  % 别忘了加上从最后一个城市返回到最开始那个城市的距离
end