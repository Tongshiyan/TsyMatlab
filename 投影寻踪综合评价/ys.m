%% 满足a的约束条件
function out_a=ys(n,n_chr)
out_a=[];
k=0;
    while k~=n
        a=zeros(1,n_chr);
        for i=1:n_chr-1
            a(i)=rand;
        end
        sum0=sum(a(1:n_chr-1).^2);
        if sum0>1
          
            continue;
        else 
            k=k+1;
            a(n_chr)=sqrt(1-sum0);
            out_a=cat(1,out_a,a);
        end
    end

end
