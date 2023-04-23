%% 卡尔曼滤波的封装函数
%launch_location是三发射机的位置 前两个固定是[FY_00,FY_01]的位置
%accept_location是接收机的位置
%real为真实位置
%item为第三架发射机的编号-1
%accept_item是接收机的编号-1
function out=kalman_fun(launch_location,accept_location,real,item,accept_item)
n=200;%卡尔曼滤波次数
m=2;%状态量维度
Q=[1e-5 0.01];%过程方差
R=abs(launch_location(3,:)-real(item+2,2:3));%测量方差
angle=fan_angle(accept_location,launch_location);%求解接收信息
z=sqrt(abs(main_fun(angle,[1 item+1])-real(accept_item+2,2:3))).*randn(n,m)+real(accept_item+2,2:3); %模拟定位测量值
x_hat=zeros(n,m);%后验估计
P_x=zeros(n,m);%后验估计方差
x_f=zeros(n,m);%先验估计
P_f=zeros(n,m);%先验估计方差
k=zeros(n,m);%卡尔曼增益
x_hat(1,:)=accept_location;
P_x(1,:)=abs(real(accept_item+2,2:end)-accept_location);
%卡尔曼方程
for epoch=2:n
    x_f(epoch,:)=x_hat(epoch-1,:); %更新先验估计
    P_f(epoch,:)=P_x(epoch-1,:)+Q;%更新先验估计方程
    k(epoch,:)=P_f(epoch,:)./(P_f(epoch,:)+R);%更新卡尔曼增益
    x_hat(epoch,:)=x_f(epoch,:)+k(epoch,:).*(z(epoch,:)-x_f(epoch,:));%更新后验估计
    P_x(epoch,:)=(1-k(epoch,:)).*P_f(epoch,:);%更新后验估计方差
end
out=x_hat(end,:);%最后的后验估计为输出值
end