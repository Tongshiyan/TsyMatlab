function RF_prection_ = RFprection(RF,featureGrounp,dataTrain)
     [m,n] = size(RF);
     [m2,n2] = size(dataTrain);
     RF_prection = [];
     
     for a = 1:n
         RF_single = RF(:,a);
         feature = featureGrounp(:,:,a);
         data = splitData2(dataTrain,feature);
         RF_prection_single = [];
         for b =1:m2
             A = prection(RF_single,data(b,:));
             RF_prection_single = [RF_prection_single;A];
         end    
         RF_prection = [RF_prection,RF_prection_single];  
     end    
     RF_prection_ = mode(RF_prection,2);
end