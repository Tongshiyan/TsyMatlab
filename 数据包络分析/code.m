%% 数据包络分析(DEA)
% 多输入和多输出的综合评价
clc;clear
put=[89.39 86.25 108.13 106.38 62.40 47.19;64.3 99 99.6 96 96.2 79.9]';%输入指标
out=[25.2 28.2 29.4 26.4 27.2 25.2;223 287 317 291 295 222]';%输出指标
[put_m,put_n]=size(put');
[out_m,out_n]=size(out');
for i=1:put_n
    A(i,:)=[zeros(1,out_m),put(i,:)]-[out(i,:),zeros(1,put_m)];
end
t=zeros(1,put_n);
result=zeros(out_m,1);
out=out';
for i=1:put_n
    b=[out(:,i);zeros(put_m,1)];
    aeq=[zeros(1,out_m),put(i,:)];
    dep=1;
    x=linprog(-b,-A,t,aeq,dep,zeros(put_m+out_m,1));
    result(i,1)=b'*x;   
end
disp('DEA效益为：')
disp(result)