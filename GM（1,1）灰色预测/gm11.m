function [out1,out2,out3,out4]=gm11(in1,in2)
%out1为预测值
%out2为原始数据拟合值
%out3为相对残差
%out4为级比偏差
%in1为预测的原始数据
%in2为预测期数

n=length(in1);
y0=cumsum(in1);% 计算一次累加值
z0= (y0(1:end-1) + y0(2:end)) / 2;  % 计算紧邻均值生成数列（长度为n-1）
 % 进行一元回归  
   y = in1(2:end);
   x = z0;
    k = ((n-1)*sum(x.*y)-sum(x)*sum(y))/((n-1)*sum(x.*x)-sum(x)*sum(x));
    b = (sum(x.*x)*sum(y)-sum(x)*sum(x.*y))/((n-1)*sum(x.*x)-sum(x)*sum(x));
    a = -k;  %  -a就是发展系数,  b就是灰作用量
  out2=zeros(1,n); 
  out2(1)=in1(1);   % 初始化
    for m = 1: n-1
        out2(m+1) = (1-exp(a))*(in1(1)-b/a)*exp(-a*m);
    end
    out1 = zeros(1,in2);  % 初始化用来保存预测值的向量
    for i = 1: in2
        out1(i) = (1-exp(a))*(in1(1)-b/a)*exp(-a*(n+i-1)); % 带入公式直接计算
    end
    for i=1:n
        if in1(i)==0
            in1(i)=mean(in1);
        end
    end
    % 计算绝对残差和相对残差
   jdcc = in1(2:end) - out2(2:end);   % 从第二项开始计算绝对残差
   out3 = abs(jdcc) ./ in1(2:end);  % 计算相对残差
    % 计算级比和级比偏差
    jb = in1(2:end) ./ in1(1:end-1) ;  % 计算级比
   out4 = abs(1-(1-0.5*a)/(1+0.5*a)*(1./jb));  % 计算级比偏差
end
