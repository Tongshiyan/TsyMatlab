%% 决策树 CART
%例如使用汽车特征评估质量的数据集
%tips：数据集，包括车门数量、后备箱大小、维修成本、安全性能、载人数量等等(属性)，来确定一辆汽车的质量。
%分类的目的是把车辆的质量分为4种类型：不达标、达标、良好、优秀。

clc;clear
%量化属性指标，属性的效果越好值越高一般取1,2,3，...
load target.mat%载入数据
[m,n]=size(target);
a=randperm(m);%将target随机赋值
b=floor(m*0.8);%设置前b个为训练组
%得到训练集合
train=target(a(1:b),1:end-1);%前1：end为属性，end为质量的类型
train_goal=target(a(1:b),end);%得到质量
%得到测试集合
test=target(a(b+1:end),1:end-1);
test_goal=target(a(b+1:end),end);

%% 创建决策树分类器
tree = ClassificationTree.fit(train,train_goal);
%实验组的分类
tree_predict=predict(tree,test);
%决策树的视图
view(tree);
view(tree,'mode','graph');

%% 模型检验与结果分析
num_train1 = length(find(train_goal == 1));  %训练集中车辆质量不达标个数
num_train2 = length(find(train_goal == 2));  %训练集中车辆质量达标个数
num_train3 = length(find(train_goal == 3));  %训练集中车辆质量良好个数
num_train4 = length(find(train_goal == 4));  %训练集中车辆质量优秀个数
 
rata_train1  = num_train1 / b;             %训练集中车辆质量不达标占的比例
rata_train2 = num_train2 / b;             %训练集中车辆质量达标占的比例
rata_train3 = num_train3 / b;             %训练集中车辆质量优良占的比例
rata_train4 = num_train4 / b;             %训练集中车辆质量优秀占的比例
 
total_1 = length(find(target(:,end) == 1));  %总数据中车辆质量不达标个数
total_2 = length(find(target(:,end) == 2));  %总数据中车辆质量达标个数
total_3 = length(find(target(:,end) == 3));  %总数据中车辆质量优良个数
total_4 = length(find(target(:,end) == 4));  %总数据中车辆质量优秀个数
 
num_test1 = length(find(test_goal == 1));  %测试集中车辆质量不达标个数
num_test2 = length(find(test_goal == 2));  %测试集中车辆质量达标个数
num_test3 = length(find(test_goal == 3));  %测试集中车辆质量良好个数
num_test4 = length(find(test_goal == 4));  %测试集中车辆质量优秀个数
 
count_right_1 = length(find(tree_predict == 1 & test_goal == 1));  %测试集中预测车辆质量不达标正确的个数
count_right_2 = length(find(tree_predict == 2 & test_goal == 2));  %测试集中预测车辆质量达标正确的个数
count_right_3 = length(find(tree_predict == 3 & test_goal == 3));  %测试集中预测车辆质量优良正确的个数
count_right_4 = length(find(tree_predict == 4 & test_goal == 4));  %测试集中预测车辆质量优秀正确的个数
 
rate_right = (count_right_1+count_right_2+count_right_3+count_right_4)/(n-n);

%% 输出
%根据情况改变参数
disp(['车辆总数：1728'...
      '  不达标：' num2str(total_1)...
      '  达标：' num2str(total_2)...
      '  优良：' num2str(total_3)...
      '  优秀：' num2str(total_4)]);
disp(['训练集车辆数：1500'...
      '  不达标：' num2str(num_train1)...
      '  达标：' num2str(num_train2)...
      '  优良：' num2str(num_train3)...
      '  优秀：' num2str(num_train4)]);
disp(['测试集车辆数：228'...
      '  不达标：' num2str(num_test1)...
      '  达标：' num2str(num_test2)...
      '  优良：' num2str(num_test3)...
      '  优秀：' num2str(num_test4)]);
disp(['决策树判断结果：'...
      '  不达标正确率：' sprintf('%2.3f%%', count_right_1/num_test1*100)...
      '  达标正确率：' sprintf('%2.3f%%', count_right_2/num_test2*100)...
      '  优良正确率：' sprintf('%2.3f%%', count_right_3/num_test3*100)...
      '  优秀正确率：' sprintf('%2.3f%%', count_right_4/num_test4*100)]);
  
disp(['总正确率:'... 
    sprintf('%2.3f%%', rate_right*100)]);
  
 %% 优化前决策树的重采样误差和交叉验证误差
resubDefault = resubLoss(tree);
lossDefault = kfoldLoss(crossval(tree));
disp(['剪枝前决策树的重采样误差:'... 
    num2str(resubDefault)]);
 disp(['剪枝前决策树的交叉验证误差:'... 
    num2str(lossDefault)]);
 
%% 剪枝
[~,~,~,bestlevel] = cvLoss(tree,'subtrees','all','treesize','min');
cptree = prune(tree,'Level',bestlevel);
view(cptree,'mode','graph')
 
%% 剪枝后决策树的重采样误差和交叉验证误差
resubPrune = resubLoss(cptree);
lossPrune = kfoldLoss(crossval(cptree));
disp(['剪枝后决策树的重采样误差:'... 
    num2str(resubPrune)]);
 disp(['剪枝后决策树的交叉验证误差:'... 
    num2str(resubPrune)]);

