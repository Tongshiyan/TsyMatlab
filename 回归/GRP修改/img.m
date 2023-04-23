function []=img(x,true,predict_y,P1,P2,gprMdl)
x=mapminmax('apply',x',P1)';
true1=mapminmax('apply',true',P2)';
y=predict(gprMdl,x);
yhat=mapminmax('reverse',y',P2)';
predict_y=cat(1,yhat(end),predict_y);
disp(['MSEloss=' num2str(MSEloss(true1,y))])
figure()
hold on 
plot(0:size(x,1)-1,true,'b-','linewidth',1)
plot(0:size(x,1)-1,yhat,'g-','linewidth',1)
plot(size(x,1)-1:size(x,1)+size(predict_y,1)-2,predict_y,'r-','linewidth',1)
xlabel('Date')
ylabel('SolePrice')
legend('True','Test','Predict')
end
