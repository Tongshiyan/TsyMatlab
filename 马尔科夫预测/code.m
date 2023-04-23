%% 马尔可夫预测
clc;clear
load data.mat;
n=3;%状态类型个数
x=data(:,1);
y=data(:,2);
num=length(y);%得到状态总个数

%状态转移概率矩阵
for i=1:n
    for j=1:n
        p((i-1)*n+j)=0;
    end
end
%记录状态转移的数量矩阵
for i=1:num-1
    judge=y(i+1)-y(i);
    p((y(i)-1)*n+y(i)+judge)=p((y(i)-1)*n+y(i)+judge)+1;
end
n1=zeros(n,1);%初始化起始状态量
%记录总起始状态量
for i=1:num-1
    for j=1:n
        if y(i)==j
            n1(j)=n1(j)+1;
        end
    end
end
%分割状态转移的数量矩阵
k=0;
newp=zeros(n,n);
for i=1:n
    for j=1:n
    newp(i,j)=p((i-1)*n+j);
    end
end
   %输出状态转移概率矩阵
   P=newp./n1
   
   %% 马尔可夫预测法
   predict=input('输入需要预测的期数');
   pi=zeros(predict+1,n);%初始化状态概率
   %得到起始状态概率
   for i=1:n
       if y(end)==i
           pi(1,i)=1
       end
   end
   %生成后续每期的状态概率
   for i=2:predict+1
       pi(i,:)=pi(i-1,:)*P;
   end
   disp('每期的概率矩阵')
   pi
   %% 终极概率预测
   result = null(eye(n)-P');
   result = result/sum(result)