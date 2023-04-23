%% 目标函数
%例如这种函数，x（i）对结果的影响程度不确定，应用敏感性分析
%也有可能是黑盒的程序函数，也是可以直接调用之后输入参数即可
function result=solvefunction(x)
result=sin(x(1))+7*(sin(x(2)))^2+0.1*x(3)^4*sin(x(1));
end