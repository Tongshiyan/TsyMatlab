%量子比特编码
function chr=Pop(m,n)
for i=1:m
    for j=1:n
        chr(i,j)=1/sqrt(2);
    end
end
end
