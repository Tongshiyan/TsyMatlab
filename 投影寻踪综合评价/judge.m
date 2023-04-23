%% 判断变异后是否超出边界
function  out=judge(in,range)
if in<range(1)||in>range(2)
    if abs(in-range(1))<abs(in-range(2))
        out=range(1);
    else
        out=range(2);
    end
else 
    out=in;
end