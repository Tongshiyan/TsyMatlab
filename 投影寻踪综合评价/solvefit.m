%% 适应度计算
function fitness=solvefit(chr,n,data)
fitness=zeros(n,1);%初始化适应度

for i=1:n
    z=std(data,chr(i,:));
    fitness(i)=S(z)*D(z);
end

end