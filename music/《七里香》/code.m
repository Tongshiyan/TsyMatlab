fs = 44100;
dt = 1/fs;
T16 = 0.2;
t16 = [0:dt:T16];
[temp k] = size(t16);
t2 = linspace(0,8*T16,8*k);
t3 = linspace(0,7*T16,7*k);%7/16拍
t4_25=linspace(0,5*T16,5*k);%5/16拍
t4 = linspace(0,4*T16,4*k);
t6 = linspace(0,3*T16,3*k);%3/16拍
t8 = linspace(0,2*T16,2*k);
[temp i] = size(t4);
[temp j] = size(t8);

mod2 = sin(pi*t2/t2(end));
mod3= sin(pi*t3/t3(end));
mod4 = sin(pi*t4/t4(end));
mod4_25= sin(pi*t4_25/t4_25(end));
mod6 = sin(pi*t6/t6(end));
mod8 = sin(pi*t8/t8(end));
mod16 = sin(pi*t16/t16(end));
f0 = 2*146.8;
ScaleTable = [2/3 3/4 5/6 15/16 ...
1 9/8 5/4 4/3 3/2 5/3 9/5 15/8 ...
2 9/4 5/2 8/3 3 10/3 15/4 4 ...
1/2 9/16 5/8];

% 1/4 notes
do0f = mod4.*cos(2*pi*ScaleTable(21)*f0*t4);
re0f = mod4.*cos(2*pi*ScaleTable(22)*f0*t4);
mi0f = mod4.*cos(2*pi*ScaleTable(23)*f0*t4);
fa0f = mod4.*cos(2*pi*ScaleTable(1)*f0*t4);
so0f = mod4.*cos(2*pi*ScaleTable(2)*f0*t4);
la0f = mod4.*cos(2*pi*ScaleTable(3)*f0*t4);
ti0f = mod4.*cos(2*pi*ScaleTable(4)*f0*t4);
do1f = mod4.*cos(2*pi*ScaleTable(5)*f0*t4);
re1f = mod4.*cos(2*pi*ScaleTable(6)*f0*t4);
mi1f = mod4.*cos(2*pi*ScaleTable(7)*f0*t4);
fa1f = mod4.*cos(2*pi*ScaleTable(8)*f0*t4);
so1f = mod4.*cos(2*pi*ScaleTable(9)*f0*t4);
la1f = mod4.*cos(2*pi*ScaleTable(10)*f0*t4);
tb1f = mod4.*cos(2*pi*ScaleTable(11)*f0*t4);
ti1f = mod4.*cos(2*pi*ScaleTable(12)*f0*t4);
do2f = mod4.*cos(2*pi*ScaleTable(13)*f0*t4);
re2f = mod4.*cos(2*pi*ScaleTable(14)*f0*t4);
mi2f = mod4.*cos(2*pi*ScaleTable(15)*f0*t4);
fa2f = mod4.*cos(2*pi*ScaleTable(16)*f0*t4);
so2f = mod4.*cos(2*pi*ScaleTable(17)*f0*t4);
la2f = mod4.*cos(2*pi*ScaleTable(18)*f0*t4);
ti2f = mod4.*cos(2*pi*ScaleTable(19)*f0*t4);
do3f = mod4.*cos(2*pi*ScaleTable(20)*f0*t4);
blkf = zeros(1,i);

% 1/8 notes
do0e = mod8.*cos(2*pi*ScaleTable(21)*f0*t8);
fa0e = mod8.*cos(2*pi*ScaleTable(1)*f0*t8);
so0e = mod8.*cos(2*pi*ScaleTable(2)*f0*t8);
la0e = mod8.*cos(2*pi*ScaleTable(3)*f0*t8);
ti0e = mod8.*cos(2*pi*ScaleTable(4)*f0*t8);
do1e = mod8.*cos(2*pi*ScaleTable(5)*f0*t8);
do1_6 = mod6.*cos(2*pi*ScaleTable(5)*f0*t6);
re1e = mod8.*cos(2*pi*ScaleTable(6)*f0*t8);
mi1e = mod8.*cos(2*pi*ScaleTable(7)*f0*t8);
mi1_6= mod6.*cos(2*pi*ScaleTable(7)*f0*t6);
fa1e = mod8.*cos(2*pi*ScaleTable(8)*f0*t8);
fa1_6=mod6.*cos(2*pi*ScaleTable(8)*f0*t6);
so1e = mod8.*cos(2*pi*ScaleTable(9)*f0*t8);
so1_2= mod2.*cos(2*pi*ScaleTable(9)*f0*t2);
so1_3= mod3.*cos(2*pi*ScaleTable(9)*f0*t3);
la1e = mod8.*cos(2*pi*ScaleTable(10)*f0*t8);
la1_6 = mod6.*cos(2*pi*ScaleTable(10)*f0*t6);
tb1e = mod8.*cos(2*pi*ScaleTable(11)*f0*t8);
ti1e = mod8.*cos(2*pi*ScaleTable(12)*f0*t8);
do2e = mod8.*cos(2*pi*ScaleTable(13)*f0*t8);
do2_4_25= mod4_25.*cos(2*pi*ScaleTable(13)*f0*t4_25);
do2_6=mod6.*cos(2*pi*ScaleTable(13)*f0*t6);
re2e = mod8.*cos(2*pi*ScaleTable(14)*f0*t8);
re2_6 = mod6.*cos(2*pi*ScaleTable(14)*f0*t6);
mi2e = mod8.*cos(2*pi*ScaleTable(15)*f0*t8);
mi2_6 = mod6.*cos(2*pi*ScaleTable(15)*f0*t6);
fa2e = mod8.*cos(2*pi*ScaleTable(16)*f0*t8);
fa2_6 = mod6.*cos(2*pi*ScaleTable(16)*f0*t6);
so2e = mod8.*cos(2*pi*ScaleTable(17)*f0*t8);
la2e = mod8.*cos(2*pi*ScaleTable(18)*f0*t8);
ti2e = mod8.*cos(2*pi*ScaleTable(19)*f0*t8);
do3e = mod8.*cos(2*pi*ScaleTable(20)*f0*t8);
blke = zeros(1,j);

% 1/16 notes
fa0s = mod16.*cos(2*pi*ScaleTable(1)*f0*t16);
so0s = mod16.*cos(2*pi*ScaleTable(2)*f0*t16);
la0s = mod16.*cos(2*pi*ScaleTable(3)*f0*t16);
ti0s = mod16.*cos(2*pi*ScaleTable(4)*f0*t16);
do1s = mod16.*cos(2*pi*ScaleTable(5)*f0*t16);
re1s = mod16.*cos(2*pi*ScaleTable(6)*f0*t16);
mi1s = mod16.*cos(2*pi*ScaleTable(7)*f0*t16);
fa1s = mod16.*cos(2*pi*ScaleTable(8)*f0*t16);
so1s = mod16.*cos(2*pi*ScaleTable(9)*f0*t16);
la1s = mod16.*cos(2*pi*ScaleTable(10)*f0*t16);
tb1s = mod16.*cos(2*pi*ScaleTable(11)*f0*t16);
ti1s = mod16.*cos(2*pi*ScaleTable(12)*f0*t16);
do2s = mod16.*cos(2*pi*ScaleTable(13)*f0*t16);
re2s = mod16.*cos(2*pi*ScaleTable(14)*f0*t16);
mi2s = mod16.*cos(2*pi*ScaleTable(15)*f0*t16);
fa2s = mod16.*cos(2*pi*ScaleTable(16)*f0*t16);
so2s = mod16.*cos(2*pi*ScaleTable(17)*f0*t16);
la2s = mod16.*cos(2*pi*ScaleTable(18)*f0*t16);
ti2s = mod16.*cos(2*pi*ScaleTable(19)*f0*t16);
do3s = mod16.*cos(2*pi*ScaleTable(20)*f0*t16);
blks = zeros(1,k);

violin = [blke so1e...
do2f ti1e do2s do2_4_25 blke do2e...
do2e ti1e la1e ti1s la1_6 so1f so1e...
so1f fa1e mi1s so1_3 so1e...
so1e la1_6 re1e fa1s fa1_6 mi1f so1e...
do2f ti1e do2s do2_4_25 blke do2e...
do2e ti1e do2e re2s re2_6 do2e do2e ti1e...
do2e do2s do2_6 ti1e ti1e la1e la1e ti1s la1s...
so1_2 blkf so1e do2e...
do2f mi1e la1e la1f so1e re2e...
re2f re1e fa1s fa1_6 mi1e blke so1e...
so1e fa1e fa1e mi1s mi1_6 re1e re1e do1e...
mi1e re1f fa1e mi1f so1e do2e...
do2f mi1e la1e la1e so1e so1e re2e...
re2e re1e re1e fa1e mi1e so1e so1e mi2e...
mi2e re2e re2e do2e do2e re2e do2e mi2e...
mi2_6 re2_6 blke so1e ti1e do2s do2_4_25...
blke do2e do2e la1e la1e so1e...
ti1e do2e re2_6 do2_6 so1e ti1e do2s do2_4_25...
blke do2e do2e la1e la1e so1e...
re2e mi2e fa2_6 mi2_6 so1e ti1e do2s do2_4_25...
blke do2e do2e la1e la1e so1e...
re2e do2e ti1e do2s do2_6 blke do2e...
do2e re2e re2e do2e do2e ti1e re2e do2s do2_6
];

s = violin;
s = s/max(s);

sound(s,fs);
audiowrite('Qilixiang.wav',violin,fs)
