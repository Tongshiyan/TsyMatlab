%% 去均值处理
function  out_train_data=remove_average(train_data)
out_train_data=train_data-mean(mean(train_data));
end