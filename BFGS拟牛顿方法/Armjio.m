function [alpha] = Armjio(fun, grid, x0, dk)
    %
    % Function [alpha, xk, fx, k] = Armjio(fun, grid, x0, dk)
    % 求出函数fun在x0处以dk为下降方向时的步长alpha，同时返回相对应的下
    % 一个下降点xk以及xk处的函数值fx，k为迭代次数
    % -----------------------------------------------------------
    % 输入: 
    % 		fun 	函数名称(字符变量）
    %		grid 	梯度函数名称(字符变量)
    %		x0		迭代点(列向量)
    %		dk		函数在迭代点处的下降方向(列向量)
    %
    % 输出:
    %		alpha	函数在x0处以dk为下降方向时的下降步长
    %		xk		函数在x0处以dk为下降方向，以alpha为步长
    %				求得的下降点
    %		fx		函数在下降点xk处的函数值
    %		k		求步长算法迭代次数
    % -----------------------------------------------------------
    % by Zhi Qiangfeng 
    %
    beta = 0.333; 		% 步长 alpha 的迭代系数，小于 1
    rho = 1e-3; 		% 泰勒展开式补足系数，0 < rho < 1/2
    alpha = 1; 			% 初始步长为 1
    k = 0; 				% 统计迭代次数
    g=grid;
    gk = g(x0(1),x0(2));	% x0处的梯度值
    fd = feval(fun, x0 + alpha * dk); 	% 函数在下一个迭代点处的目标函数值
    fk = feval(fun, x0) + alpha * rho * gk' * dk; 	% 函数在下一个迭代点处的泰勒展开值
    while fd > fk
        alpha = beta * alpha;
        fd = feval(fun, x0 + alpha * dk);
        fk = feval(fun, x0) + alpha * rho * gk' * dk;
        k = k + 1;
    end
end

