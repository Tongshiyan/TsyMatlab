%% 交叉过程
function newchr=solveacr(chr,acr,n,n_chr)
for i=1:n
    p=rand;
    if p<acr %此处是将随机两个个体的随机两个染色体进行交换
        acr_chr = floor((n-1)*rand+1); %要交叉的染色体
        acr_n = floor((n_chr-1)*rand+1); %要交叉的节点
        swag=chr(i,acr_n);
        chr(i,acr_n)=chr(acr_chr,acr_n);
        chr(acr_chr,acr_n)=swag;
    end
end
newchr=chr;
end