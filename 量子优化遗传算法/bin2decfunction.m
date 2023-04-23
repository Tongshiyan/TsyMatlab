%% 二进制转十进制
% 输入      bin：二进制编码
%    range_len：各变量的二进制位数
%       range：各变量的范围
% 输出      dec：十进制数
function dec=bin2decfunction(bin,range_len,range)

m=length(range_len);
n=1;
dec=zeros(1,m);
for i=1:m
    for j=range_len(i)-1:-1:0
        dec(i)=dec(i)+bin(n).*2.^j;
        n=n+1;
    end
end
dec=range(:,1)'+dec./(2.^range_len-1).*(range(:,2)-range(:,1))'; 