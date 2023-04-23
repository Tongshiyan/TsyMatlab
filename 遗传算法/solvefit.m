%% 适应度计算
function fitness=solvefit(chr,n,n_chr)
fitness=zeros(n,1);
x=zeros(1,n_chr);
for i=1:n
    for j=1:n_chr
        x(j)=chr(i,j);
    end
    fitness(i)=sin(x(1))+cos(x(2))+0.1*(x(1)+x(2));%代价函数,得到适应度
end
end