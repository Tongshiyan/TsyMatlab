clc;clear
load x.mat
x(:,4)=max(x(:,4))-x(:,4);
w=sq(x)
out=mytop(x)
