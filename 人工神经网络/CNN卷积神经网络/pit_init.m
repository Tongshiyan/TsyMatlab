%% 卷积核初始化
%因为输入层是28*28，卷积层后为24*24*20所以卷积核数为5*5
function [pit_c1,pit_f1]=pit_init(num_c1,num_f1,num_pit_c1,num_pit_f1)
   pit_c1=zeros(num_pit_c1,num_pit_c1,num_c1);
   pit_f1=zeros(num_pit_f1,num_pit_f1,num_f1);%初始化
   for i=1:num_c1
    pit_c1(:,:,i)=(2*rand(num_pit_c1,num_pit_c1)-ones(num_pit_c1,num_pit_c1))/num_pit_f1;
   end
   for i=1:num_f1
    pit_f1(:,:,i)=(2*rand(num_pit_f1,num_pit_f1)-ones(num_pit_f1,num_pit_f1));
   end
end