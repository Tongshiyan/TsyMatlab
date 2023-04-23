function [data,feature] = chooseSample(data1,featureNum,dataNum)
   [m,n] = size(data1);
     B = randperm(n-1);
     feature = B(1,1:featureNum);
    C= zeros(1,dataNum);
        A = randperm(m);
        C(1,:) = A(1,1:dataNum);
    data= data1(C,feature);
    data = [data,data1(C,n)];
end