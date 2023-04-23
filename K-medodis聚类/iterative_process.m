function [cx,cost] = iterative_process(K,data,num)
%   生成将data聚成K类的最佳聚类
%   K为聚类数目，data为数据集,num为随机初始化次数
    [cx,cost] = Kmedoids(K,data);
    for i = 2:num
        [cx1,min] = Kmedoids(K,data);
        if min<cost
            cost = min;
            cx = cx1;
        end
    end
end