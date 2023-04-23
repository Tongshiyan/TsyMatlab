function  note = buildCartTree(data,k)
  k = k + 1;
  [m,n] = size(data);

   if m == 0
      note = struct();
   else
      currentGini =  calGiniIndex(data);
      bestGini = 0;
      featureNum = n - 1;
      for a = 1:featureNum   
          feature_values = unique(data(:,a));
          [m1,n1] = size(feature_values);
          for b = 1:m1
              [D1,D2] = splitData(data,a,feature_values(b,n1));
              [m2,n2] = size(D1);
              [m3,n3] = size(D2);
             
              Gini_1 = calGiniIndex(D1);
              Gini_2 = calGiniIndex(D2);
              nowGini = (m2*Gini_1+m3*Gini_2)/m;
              gGini = currentGini - nowGini;
            
              if gGini > bestGini && m2>0 && m3>0
                 bestGini =  gGini;
                 bestFeature = [a,feature_values(b,n1)];  
                 rightData = D1;
                 leftData = D2;
              end   
             
          end 
      end 
      if bestGini > 0
         note =  buildCartTree(rightData,k) ;
         right = note;
         note = buildCartTree(leftData,k) ;
         left = note ;
         s1 = 'bestFeature';
         s2 = 'value';
         s3 = 'rightBranch';
         s4 = 'leftBranch';
         s5 = 'leaf';
         leafValue = [];
         note =  struct(s1,bestFeature(1,1),s2,bestFeature(1,2),s3,right,s4,left,s5,leafValue);
      else
         leafValue = data(1,n);
         s1 = 'leaf';
         note = struct(s1,leafValue);
      end    
   end
end