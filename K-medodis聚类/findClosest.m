function [cx,cost] = findClosest(data,centroids)
% 将样本划分到最近的聚类中心
    cost = 0;
    n = size(data,1);
    cx = zeros(n,1);
    for i = 1:n
%       欧式距离
        [M,id] = min(sqrt(sum((data(i,:)-centroids).^2,2)));
        cx(i) = id;
        cost = cost+M;
    end
end