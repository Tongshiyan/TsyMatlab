function data = splitData2(dataTrain,feature)
   [m,n] = size(dataTrain);
   [m1,n1] = size(feature);
   data = zeros(m,m1);

   data(:,:) = dataTrain(:,feature);
end