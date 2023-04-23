function Gini = calGiniIndex(data)
    [m,n] = size(data);
    if  m == 0
        Gini = 0;
    else
        labelsNum = labels_num2(data);
        [m1,n1] = size(labelsNum);
        
        Gini = 0;
        for a = 1:m1
            Gini = Gini + labelsNum(a,n1)^2;
        end    
        Gini = 1 - Gini/(m^2);
    end    
end