%% 主程序BFGS拟牛顿算法
%主用于已知映射函数的优化计算 
clc;clear
X = randi([-10, 10], 1, 1) * rand(2, 10);%定义初始点，每列为一个样本
eps = 1e-5;
kmax = 3000;
file = fopen("./BFGSdata.txt", "w");
fprintf(file, "初始点\t\t\t\t\t 极小点\t\t\t\t  目标函数值\t\t 迭代次数\t 运行时间\n");
for i = 1:10
    tic 
    x0 = X(:, i);
    [f, xk, k] = BFGS(x0, @Rosenbrock, grid, eps, kmax);
    t = toc;
    fprintf(file, "[%f, %f]\t[%f, %f]\t%f\t\t%d\t\t\t%f\n", x0(1), x0(2), xk(1), xk(2), f, k, t);
end  