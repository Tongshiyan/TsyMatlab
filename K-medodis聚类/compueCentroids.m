function centroids = compueCentroids(data,cx,K)
% 计算新的聚类中心
    centroids = zeros(K,size(data,2));
    for i = 1:K
%       寻找代价值最小的当前聚类中心
        temp = data((cx==i),:);
        [~,I] = min(sum(squareform(pdist(temp))));
        centroids(i,:) = temp(I,:);
    end
end