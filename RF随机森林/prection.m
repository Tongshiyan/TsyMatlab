
function A = prection(RF_single,sample)
    if isempty(RF_single.leaf) == 0 
       A =  RF_single.leaf;
    else
       B = sample(1,RF_single.bestFeature);
       if B >= RF_single.value
           branch = RF_single.rightBranch;
       else
           branch = RF_single.leftBranch;
       end 
       A = prection(branch,sample);
    end    
end