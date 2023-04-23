%SVD奇异值分解压缩
function [M]=mysvd(A,r)
[U,S,V]=svd(A);%V储存的是未经过转置的矩阵，S储存奇异值矩阵
eigs=diag(S);%产生奇异值的列向量，diag（）将S对角元素转成列向量
Sum=sum(eigs);%奇异值的和
temp=0;%初始化奇异值的和
for i=1:length(eigs)
   temp=temp+eigs(i);
   if(temp/Sum)>r
       break
   end
end
M=U(:,1:i)*S(1:i,1:i)*V(:,1:i)'%生成压缩矩阵，压缩矩阵的大小不变但是秩减少
end
       