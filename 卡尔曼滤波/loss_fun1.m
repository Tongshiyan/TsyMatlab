%得到一个关于2-9号无人机距离真实值的偏差
function loss=loss_fun1(y_hat,real)
MSE=zeros(8,2);
for i=1:8
    MSE(i,:)=(y_hat(i,:)-real(i+2,2:3)).^2;
end
guiyi=MSE./sum(MSE);
loss=guiyi(:,1)+guiyi(:,2);
end