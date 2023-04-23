%% 求解Da
function da = D(z)
%  R = r_m+3;
n = size(z,1);%默认为是一行n列
sum0 = 0;
r=zeros(n);
for i = 1:n
    for k = 1:n
        r(i,k) = abs(z(i)-z(k));
        % sum0 = sum0+(R-r(i,k))*fun(R-r(i,k));
    end
end

R = rand*(max(max(r))/3-max(max(r))/5)+max(max(r))/5;



for i = 1:n
    for k = 1:n
       sum0 = sum0+(R-r(i,k))*fun(R-r(i,k));
    end
end

da = sum0;
end
