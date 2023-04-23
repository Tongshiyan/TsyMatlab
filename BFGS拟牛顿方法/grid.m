%% 梯度函数文件
function g = grid(~)
syms a b 

g_out=Rosenbrock([a;b]);
grad_ff=gradient(g_out,[a b]);
g=matlabFunction(grad_ff);

end
