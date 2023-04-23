function [out]=log1(in)
n=length(in);
out=zeros(n,1);
for i=1:n
    if in(i)==0
        out(i)=0;
    else
        out(i)=log(in(i));
    end
end
end