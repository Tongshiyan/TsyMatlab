function [out]=sq(in)
[r,c]=size(in);
if sum(sum(in<0))==0
    bin=in./sqrt(repmat(sum(in.*in),r,1));
else
    bin=(in-repmat(min(in),r,1))./(repmat(max(in),r,1)-repmat(min(in),r,1));%标准化矩阵
end
p=bin./repmat(sum(bin),r,1);%得到概率矩阵
d=zeros(1,c);
for i=1:c
    p1=p(:,i);
    e=-sum(p1.*log1(p1))/log(r);
    d(i)=1-e;
end
out=d./sum(d);%信息熵


