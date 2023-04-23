%% 随机森林框架
%accuracy为计数量
%RF_out为随机森林结构体模型
%featureGrounp为每颗决策树的特征值
function [accuracy,RF_out,featureGrounp] = RF(treeNum ,featureNum,dataNum ,dataTrain,dataTest)
[dataAll,featureGrounp] = dataSet(dataTrain,treeNum,featureNum,dataNum);
RF_out = buildRandForest(dataAll,treeNum);
RF_prection = RFprection(RF_out,featureGrounp,dataTest);
accuracy = calAccuracy(dataTest,RF_prection);
end
