%% 自适应卡尔曼滤波
%系统描述：
%某一接收机的真实值已知状态为极坐标的两项参数，极长和角度
%kalman_fun函数因为其中有随机的正态分布 每次输出的结果不一样但每次的精度都很高
%循环10遍避免偶然因素发生
clc;clear
close all
%当前值
load data.mat
%真实值
load real.mat
location=data(3:end,2:3);%初始，动态更新的2-9编号位置
output=zeros(100,2+8*2);%输出
j=0;%输出索引
n=10;
kalman_cell=cell(n,3);
tic
for t=1:n
    j=0;
    location=data(3:end,2:3);
    output=zeros(100,2+8*2);
while 1
    loss=loss_fun1(location,real);
    [sort_loss,item]=sort(loss); %得到对应各个loss的编号item
    location1=[];
    %3发射机
    for i=1:8
        if i~=item(1)
            location1=cat(1,location1,kalman_fun([0 0;100 0;location(item(1),:)],location(i,:),real,item(1),i));
        else
            location1=cat(1,location1,location(item(1),:));
        end
    end
    new_loss1=loss_fun1(location1,real);
    %4发射机
    location2=[];
    for i=1:8
        if i~=item(1) && i~=item(2)
             location2=cat(1,location2,kalman_fun([0 0;100 0;location(item(2),:)],location(i,:),real,item(2),i));
        else
              if i==item(1)
                 location2=cat(1,location2,location(item(1),:));
                else
                location2=cat(1,location2,location(item(2),:));
             end
        end
    end
    %将发射机的位置重置
    location2=(location1+location2)./2;
    location2(item(1),:)=location(item(1),:);
    location2(item(2),:)=location(item(2),:);
    %判断优劣
    new_loss2=loss_fun1(location2,real);
    judge_loss=zeros(8,2);
    judge_loss(:,1)=new_loss1;
    judge_loss(:,2)=new_loss2;
    sum_loss=sum(judge_loss);
    if sum_loss(1)>sum_loss(2)
        flag=0;
    else
        flag=1;
    end
    %输出
        j=j+1;
    if flag==0
        out_item=[item(1),0];
        location=location1;
        output(j,1:2)=out_item;
        for i=1:8
           output(j,2*i+1:2*i+2)=location(i,:);
        end
        
    else
        out_item=[item(1),item(2)];
        location=location2;
        output(j,1:2)=out_item;
        for i=1:8
            output(j,2*i+1:2*i+2)=location(i,:);
        end
    end
    %退出循环
    break_loss=loss_fun1(location,real);
    if min(break_loss)<1e-4
        break;
    end
end
%删除多余项,整理输出
output(j+1:end,:)=[];
i=2;
while i<=size(output,1) %将两次发射机相同更改
    if sum(output(i,1:2)==output(i-1,1:2))==2
        a=output(1:i-2,:);
        b=output(i:end,:);
        output=[a;b];
    end
   i=i+1;
end
%存储
kalman_cell{t,1}=output;
kalman_cell{t,2}=size(output,1);
p=zeros(8,2);
for i=1:8
    p(i,:)=output(end,2*i+1:2*i+2);
end
kalman_cell{t,3}=find(loss_fun1(p,real)==min(loss_fun1(p,real)))+1;
end
%打印结果
min_item=1;
for i=2:n
    if kalman_cell{min_item,2}>kalman_cell{i,2}
        min_item=i;
    end
end
disp(['得出较优的调整方案为第   ' num2str(min_item)  '  个方案'])
disp(['其最精确的无人机编号为FY_0',num2str(kalman_cell{min_item,3})]);
save_mat=kalman_cell{min_item,1};
save('save_mat','save_mat');
disp('结果输出完成')
disp('结果注释：前两列为除了FY_00和FY_01选择的发射机,后几列每两列组成一组坐标依次表示编号2-9的无人机位置')
toc