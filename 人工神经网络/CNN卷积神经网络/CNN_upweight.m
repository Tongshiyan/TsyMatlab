%%    完成参数更新，权值和卷积核
function [kernel_c1,kernel_f1,weight_f1,weight_output,bias_c1,bias_f1]=CNN_upweight(yita,Error_cost,classify,train_data,state_c1,state_s1,state_f1,state_f1_temp,...
                                                                                                output,kernel_c1,kernel_f1,weight_f1,weight_output,bias_c1,bias_f1)
%% 结点数目
layer_c1_num=size(state_c1,3);
layer_s1_num=size(state_s1,3);
layer_f1_num=size(state_f1,2);
layer_output_num=size(output,2);

[c1_row,c1_col,~]=size(state_c1);
[s1_row,s1_col,~]=size(state_s1);

[kernel_c1_row,kernel_c1_col]=size(kernel_c1(:,:,1));
[kernel_f1_row,kernel_f1_col]=size(kernel_f1(:,:,1));
%% 保存网络权值
kernel_c1_temp=kernel_c1;
kernel_f1_temp=kernel_f1;

weight_f1_temp=weight_f1;
weight_output_temp=weight_output;
%% Error计算
label=zeros(1,layer_output_num);
label(1,classify+1)=1;
delta_layer_output=output-label;
%% 更新weight_output
for n=1:layer_output_num
    delta_weight_output_temp(:,n)=delta_layer_output(1,n)*state_f1';
end
weight_output_temp=weight_output_temp-yita*delta_weight_output_temp;

%% 更新bias_f1以及kernel_f1
for n=1:layer_f1_num
    count=0;
    for m=1:layer_output_num
        count=count+delta_layer_output(1,m)*weight_output(n,m);
    end
    %bias_f1
    delta_layer_f1(1,n)=count*(1-tanh(state_f1(1,n)).^2);
    delta_bias_f1(1,n)=delta_layer_f1(1,n);
    %kernel_f1
    delta_kernel_f1_temp(:,:,n)=delta_layer_f1(1,n)*state_f1_temp(:,:,n);
end
bias_f1=bias_f1-yita*delta_bias_f1;
kernel_f1_temp=kernel_f1_temp-yita*delta_kernel_f1_temp;
%% 更新weight_f1
for n=1:layer_f1_num
    delta_layer_f1_temp(:,:,n)=delta_layer_f1(1,n)*kernel_f1(:,:,n);
end
for n=1:layer_s1_num
    for m=1:layer_f1_num
        delta_weight_f1_temp(n,m)=sum(sum(delta_layer_f1_temp(:,:,m).*state_s1(:,:,n)));
    end
end
weight_f1_temp=weight_f1_temp-yita*delta_weight_f1_temp;

%% 更新 bias_c1
for n=1:layer_s1_num
    count=0;
    for m=1:layer_f1_num
        count=count+delta_layer_f1_temp(:,:,m)*weight_f1(n,m);   
    end
    delta_layer_s1(:,:,n)=count;
    delta_layer_c1(:,:,n)=kron(delta_layer_s1(:,:,n),ones(2,2)/4).*(1-tanh(state_c1(:,:,n)).^2);
    delta_bias_c1(1,n)=sum(sum(delta_layer_c1(:,:,n)));
end
bias_c1=bias_c1-yita*delta_bias_c1;
%% 更新 kernel_c1
for n=1:layer_c1_num
    delta_kernel_c1_temp(:,:,n)=rot90(conv2(train_data,rot90(delta_layer_c1(:,:,n),2),'valid'),2);
end
kernel_c1_temp=kernel_c1_temp-yita*delta_kernel_c1_temp;

%% 网络权值更新
kernel_c1=kernel_c1_temp;
kernel_f1=kernel_f1_temp;

weight_f1=weight_f1_temp;
weight_output=weight_output_temp;

end
