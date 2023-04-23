%% 替换劣等解
function  [newchr,newfitness]=solveworse(chr,best_chr,fitness)
max0=max(fitness);
min0=min(fitness);
lim=(max0-min0)*0.2+min0;%限制适应度：淘汰最后20%的个体
replace=fitness<lim;
n=sum(replace);
chr(replace,:)=ones(n,1)*best_chr(1:end-1);
fitness(replace)=ones(n,1)*best_chr(end);
newchr=chr;
newfitness=fitness;
end