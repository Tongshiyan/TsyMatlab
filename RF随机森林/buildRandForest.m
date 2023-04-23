
function RF = buildRandForest(dataTrain,treeNum)
     RF = [];
   
     fprintf('正在训练随机森林，共%d课树\n',treeNum);
for a = 1: treeNum
     data = dataTrain(:,:,a);
     note = buildCartTree(data,0);
     fprintf('第%d课树训练完成\n',a);
     RF = [RF,note];
     fprintf('===============分界线================\n');
end   
    disp('随机森林训练完成！')
end