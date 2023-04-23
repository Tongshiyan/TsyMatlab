%得到二进制编码函数
function bin=coll(chr)
[m,n]=size(chr);
m=m/2;%得到种群大小
bin=zeros(m,n);%二进制编码初始化
for i=1:m
    for j=1:n
        r=rand;
        if r>(chr(2.*i-1,j)^2)  %随机数大于α平方（自旋向上）
            bin(i,j)=1;
        else
            bin(i,j)=0;
        end
    end
end
end
