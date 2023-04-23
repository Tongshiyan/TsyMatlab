function  [dataAll,featureAll] = dataSet(dataTrain,treeNum,featureNum,dataNum)%数据集建立子函数
   dataAll = zeros(dataNum,featureNum+1,treeNum);
   featureAll = zeros(featureNum,1,treeNum);
   for a = 1: treeNum
    [data,feature] = chooseSample(dataTrain,featureNum,dataNum);
    dataAll(:,:,a) = data;
    featureAll(:,:,a) = feature';
   end 
end