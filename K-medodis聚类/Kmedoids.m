function [cx,cost] = Kmedoids(K,data)
%   把分类数据集data聚成K类
%   [cx,cost] = kmeans(K,data)
%   K为聚类数目，data为数据集
%   cx为样本所属聚类，cost为此聚类的代价值
% 选择需要聚类的数目

% 随机选择聚类中心
    centroids = data(randperm(size(data,1),K),:);
% 迭代聚类 
    centroids_temp = zeros(size(centroids));
    num = 0;
    while (~isequal(centroids_temp,centroids)&&num<20) 
        centroids_temp = centroids;
        [cx,cost] = findClosest(data,centroids);
        centroids = compueCentroids(data,cx,K);
        num = num+1;
    end
%     cost = cost/size(data,1);

end