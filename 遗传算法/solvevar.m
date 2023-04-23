%% 变异过程 对所有单个个体进行变异处理
function newchr=solvevar(chr,var,n,n_chr,range_chr,i,ger)
for j=1:n
    for k=1:n_chr
        p=rand;
        if p<var
            pm=rand;%浮点类型增加减少因子
            change=rand*(1-i/ger)^2;%迭代次数越多，变化越少
            if pm<=0.5
                chr(j,k)=chr(j,k)*(1-change);
            else
                  chr(j,k)=chr(j,k)*(1+change);
            end
            chr(j,k)=judge(chr(j,k),range_chr(:,k));%判断变异后是否超出边界
        end
    end
end
newchr=chr;
end