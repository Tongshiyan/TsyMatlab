function [out] = fan_angle(x,xp)

%x是未知点，xp是三个点，a是第三个点的序号
%% 求解out

out(1) = abs(atand((x(1)*sind(x(2)))/(x(1)*cosd(x(2))))-atand((x(1)*sind(x(2)))/(x(1)*cosd(x(2))-100)));
if out(1)>=90
    out(1)=180-out(1);
end

out(2) = abs(atand((x(1)*sind(x(2)))/(x(1)*cosd(x(2))))-atand((x(1)*sind(x(2))-xp(3,1)*sind(xp(3,2)))/(x(1)*cosd(x(2))-xp(3,1)*cosd(xp(3,2)))));
if out(2)>=90
    out(2)=180-out(2);
end


out(3) = abs(atand((x(1)*sind(x(2))-xp(3,1)*sind(xp(3,2)))/(x(1)*cosd(x(2))-xp(3,1)*cosd(xp(3,2))))- atand((x(1)*sind(x(2)))/(x(1)*cosd(x(2))-100)));
if out(3)>=90
        out(3)=180-out(3);
elseif  0<x(2)&&x(2)<xp(3,2)&&xp(3,2)<180
    out(3)=180-out(3);
elseif  x(2)>xp(3,2)&&x(2)<360&&xp(3,2)>180
    out(3)=180-out(3);
end



end


