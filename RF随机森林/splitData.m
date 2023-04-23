function [Data1,Data2] = splitData(data,fea,value)

     D1 = [];
     D2 = [];
     [m,n] = size(data);
     if m == 0
       D1 = 0;
       D2 = 0;  
     else    
        D1 = find(data(:,fea) >= value);
        D2 = find(data(:,fea) < value);   
        Data1 = data(D1,:);
        Data2 = data(D2,:);
     end
end