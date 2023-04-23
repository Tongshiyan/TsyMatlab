%统计标签中不同类型标签的数量
function labelsNum = labels_num2(data)
      [m,n] = size(data);
   
     if m == 0
        labelsNum = 0; 
     else    
      labels = data(:,n);
      
     A = unique(labels,'sorted');
     [m1,n1] = size(A);
     B = zeros(m1,2);
     B(:,1) = A(:,1);
     for a = 1:m1
          B(a,2) = size(find(labels == A(a,1)),1);
     end    
     labelsNum = B;
     end
end