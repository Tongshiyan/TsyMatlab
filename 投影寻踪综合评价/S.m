%% 求解Sa
function S_a = S(z)
%   此求S(a)
n = size(z,1);%n行一列
z_mean = sum(z)/n;
S_a = sqrt( 1/n*(sum((z-z_mean).^2)) );

end
