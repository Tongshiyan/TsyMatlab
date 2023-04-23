%% 超平面线性可分的Rosenblatt感知机 
clc;clear
load data.mat;%前end-1个是自变量 end列是类型
%条件w0+w1x1+w2x2....>=0为划分界限
%% 初始化参数
n=0;%正确划分点的个数
a=0.1;%学习率
i=0;%循环指针
num=size(data);
w=zeros(num(2),1);
%得到多维w的界限
%% 训练集和测试集的初始化
num1=round(num(1)*0.8);%训练集个数
train_x=data(1:num1,1:num(2)-1);%训练集x
test_x=data(num1+1:num(1),1:num(2)-1);%测试集x
train_y=data(1:num1,num(2));%训练集y
test_y=data(num1+1:num(1),num(2));%测试集y
%% 开始训练
while n~=num1
    i=mod(i,num1);
    sum0=w(1);%硬限幅器的值
    for j=2:num(2)
        sum0=sum0+w(j)*train_x(i+1,j-1);
    end
    if sum0 >=0 %硬限幅器符合划分条件
        y=1;
    else
        y=-1;
    end
    if y==train_y(i+1)
        i=i+1;
        n=n+1;
    else
    %n=0;
        while y~=train_y(i+1)
             sum1=w(1);%硬限幅器的值
              for j=2:num(2)
              sum1=sum1+w(j)*train_x(i+1,j-1);
             end
            if sum1>=0
                y=1;
            else
                y=-1;
            end
            %更新权重
            w(1)=w(1)+a*(train_y(i+1)-y);
            for k=2:num(2)
                w(k)=w(k)+a*(train_y(i+1)-y)*train_x(i+1,k-1);
            end
            
        end
        judge_y=zeros(num1,1);
        for p=1:num1
        total=w(1);
         for q=2:size(w,1)
          total=total+w(q)*train_x(p,q-1);
          end
    if total>=0
        judge_y(p)=1;
    else
        judge_y(p)=-1;
    end
        end
        if sum(judge_y==train_y)/num1<0.83
            n=0;
        end 
   end
        i=i+1;
        n=n+1;
    end

disp('多维w的值为：')
disp(w)

%% 测试与评价
test_y0=zeros(size(test_x,1),1);%初始化测试集的预测参数
for p=1:size(test_x,1)
    sum2=w(1);
    for q=2:size(w,1)
        sum2=sum2+w(q)*test_x(p,q-1);
    end
    if sum2>=0
        test_y0(p)=1;
    else
        test_y0(p)=-1;
    end
end
correct=sum(test_y0==test_y)/size(test_x,1);
disp('Rosenblatt感知机的预测准确率')
disp([num2str(correct*100) '%'])
disp('---------------分割线-----------------')

%% 预测与输出
load predict_x;
predict_y=zeros(size(predict_x,1),1);%初始化预测的概率
predict_y0=zeros(size(predict_x,1),1);%初始化预测的结果0 / 1
for p=1:size(predict_x,1)
    sum3=w(1);
    for q=2:size(w,1)
        sum3=sum3+w(q)*test_x(p,q-1);
    end
    predict_y(p)=sum3;
    if sum3>=0
    predict_y0(p)=1;
    else
    predict_y0(p)=-1;
    end
end
disp('预测数据的概率是')
disp(predict_y)
disp('预测数据的结果是')
disp(predict_y0)