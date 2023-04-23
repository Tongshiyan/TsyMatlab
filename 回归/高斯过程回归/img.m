%% 画图
function []=img(gprMdl,train_x0,i,P2)
[pred,~,ci] = predict(gprMdl,train_x0);
xtest=1:size(train_x0,1);
  pred1=mapminmax('reverse',pred',P2)';%2*4
  pred=pred1(:,i);
  ci1=mapminmax('reverse',ci(:,1)',P2)';
  ci2=mapminmax('reverse',ci(:,2)',P2)';
  ci(:,1)=ci1(:,i);
  ci(:,2)=ci2(:,i);
figure
plot(xtest,pred,'r','DisplayName','Prediction');
hold on;
plot(xtest,ci(:,1),'c','DisplayName','Lower 95% Limit');
plot(xtest,ci(:,2),'k','DisplayName','Upper 95% Limit');
legend('show','Location','Best');
end
