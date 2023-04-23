%% CNN卷积神经网络
% 该代码为一层卷积，既只有一个卷积层、一个池化层、一个全链接层
% 节点数目：输入层（图像）28*28 卷积层：24*24*20 池化层：12*12*20 全链接层：100
% 池化（pooling）层的主要目的为降维，一般是将卷积层缩小一半
% 卷积核大小=输入层大小-目标卷积层大小+1
% 该神经网络其实作用于图片分类，通过区块识别，得到概率极大值表示该元素的类别
%该cnn神经网络识别的例子是灰度0-9数字图像
clc;clear;
%% CNN层初始化
num_c1=20;%过滤器通道数
num_s1=20;%池化通道
num_f1=100;%全链接数
num_out=10;%输出结果数
num_pit_c1=5;%卷积核大小
num_pit_f1=12;%池化大小
%权值调整
step=0.01;
%bias初始化，倾向初始化
bias_c1=(2*rand(1,num_c1)-ones(1,num_c1))/sqrt(num_c1);
bias_f1=(2*rand(1,num_f1)-ones(1,num_f1))/sqrt(num_c1);
%卷积核
[pit_c1,pit_f1]=pit_init(num_c1,num_f1,num_pit_c1,num_pit_f1);
%池化层初始化
pooling_init=ones(2,2)*4;
%全链接层权值
weight_f1=(2*rand(num_c1,num_f1)-ones(num_c1,num_f1))/sqrt(num_c1);
weight_out=(2*rand(num_f1,num_out)-ones(num_f1,num_out))/sqrt(num_f1);
%初始化完成
%% 网络训练

for i=1:num_c1
    for n=1:num_s1
        for m=0:9%训练样本数
        train_data=rgb2gray(double(imread(strcat('Data',num2str(m),'.png'))));%读取样本
        train_data=remove_average(train_data);
        %向前传递，进入卷积层1
        for j=1:num_c1
            c1_state(:,:,j)=convolution(train_data,pit_c1(:,:,j));%卷积
            c1_state(:,:,j)=tanh(c1_state(:,:,j)+bias_c1(1,j));%激励函数双曲正切
            s1_state(:,:,j)=pooling(c1_state(:,:,j),pooling_init);%池化
        end
        %进入全链接1层
         [f1_state_pre,f1_state_temp]=f1(s1_state,pit_f1,weight_f1);
         %进入激励函数
        for k=1:num_f1
            f1_state(1,k)=tanh(f1_state_pre(:,:,k)+bias_f1(1,k));
        end
          %进入softmax层
        for k=1:num_out
            out(1,k)=exp(f1_state*weight_out(:,k))/sum(exp(f1_state*weight_out));
        end
        % 误差计算
        err=-out(1,m+1);
        %调参
         [pit_c1,pit_f1,weight_f1,weight_out,bias_c1,bias_f1]=CNN_upweight(step,err,m,train_data,...
                                                                           c1_state,s1_state,...
                                                                           f1_state,f1_state_temp,...
                                                                           out,...
                                                                           pit_c1,pit_f1,weight_f1,weight_out,bias_c1,bias_f1);
        end
    end
end
%训练完成
disp('训练完成')
%% 检验部分
count=0;

for i=1:num_c1
    for n=1:num_s1
        for m=1:5%训练样本数
        train_data=double(imread(strcat('Data',num2str(m),'.png')));%读取样本
        train_data=remove_average(train_data);
        %向前传递，进入卷积层1
        for j=1:num_c1
            c1_state(:,:,j)=convolution(train_data,pit_c1(:,:,j));%卷积
            c1_state(:,:,j)=tanh(c1_state(:,:,j)+bias_c1(1,j));%激励函数双曲正切
            s1_state(:,:,j)=pooling(c1_state(:,:,j),pooling_init);%池化
        end
        %进入全链接1层
         [f1_state_pre,f1_state_temp]=f1(s1_state,pit_f1,weight_f1);
         %进入激励函数
        for k=1:num_f1
            f1_state(1,k)=tanh(f1_state_pre(:,:,k)+bias_f1(1,k));
        end
          %进入softmax层
        for k=1:num_out
            out(1,k)=exp(f1_state*weight_out(:,k))/sum(exp(f1_state*weight_out));
        end
      [p,classify]=max(out);
        if (classify==m+1)
            count=count+1;
        end
          fprintf('真实数字为%d  网络标记为%d  概率值为%d \n',m,classify-1,p);
        end
    end
end
