function [f, xk, k] = BFGS(x0, fun, grid, eps, kmax)
    %
    % function [f, xk, k] = BFGS(x0, fun, grid, eps, kmax)
    % 求出函数fun从初始点x0处以拟牛顿方向为下降方向，
    % 采用 Armjio 准则计算迭代步长，求出函数的极小点
    % -----------------------------------------------------------
    % 输入:
    % 	x0    初始点(列向量)
    % 	fun 	函数文件名称(字符变量）
    %		grid 	梯度函数文件名称(字符变量)
    %		eps   精度要求
    %     kmax  函数的最大迭代次数
    %
    % 输出:
    %		  f	    函数在极小值 xk 处的目标函数值
    %		  xk		函数采用此方法求得的极小点
    %	  	k		  求极小点算法迭代次数
    % -----------------------------------------------------------
    % by Zhi Qiangfeng 
    % 
  k = 0;
  n = length(x0);
  H0 = eye(n); % 初始选取单位阵作为Hessen矩阵的逆的近似阵
  Hk = H0;
  xk = x0;
  g=grid;
  gk = g(xk(1),xk(2));
  while k <= kmax
      if norm(gk) < eps
          break;
      end
      dk = -Hk * gk; % 拟牛顿下降方向
      alpha = Armjio(fun, grid, xk, dk);
      x_ = xk; % x_ 保存上一个点坐标
      xk = x_ + alpha * dk; % 更新 xk
      gk_ = gk; % gk_ 保存上一个点的梯度值
      gk = g(xk(1),xk(2)); % 更新 gk
      sk = xk - x_; % 记 xk - x_ 为 sk
      yk = gk - gk_; % 记 gk - gk_ 为 yk
      if sk' * yk > 0
          v = yk' * sk;
          % BFGS公式
          Hk = Hk + (1 + (yk' * Hk * yk) / v) * (sk * sk') / v - (sk * yk' * Hk + Hk * yk * sk') / v;
      end
      k = k + 1;
  end
  f = feval(fun, xk);
end
