%% 寻找最优染色体和适应度
function best_chr = findbest_chr(chr,fitness,n_chr)
best_chr = zeros(1, n_chr+1);
[max0, max1] = max(fitness);
best_chr(1:n_chr) =chr(max1, :);
best_chr(end) = max0;
end