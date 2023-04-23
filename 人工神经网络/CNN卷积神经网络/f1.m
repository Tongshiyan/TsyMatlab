%% 全链接f1层
function [f1_state_pre,f1_state_temp]=f1(s1_state,pit_f1,weight_f1)
num_f1=size(weight_f1,2);
num_s1=size(weight_f1,1);

for i=1:num_f1
    c=0;
    for m=1:num_s1
        temp=s1_state(:,:,m)*weight_f1(m,i);
        c=c+temp;
    end
    f1_state_temp(:,:,i)=c;
    f1_state_pre(:,:,i)=convolution(f1_state_temp(:,:,i),pit_f1(:,:,i));
end
end