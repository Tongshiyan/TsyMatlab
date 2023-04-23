%% 卷积操作
function  c1_state=convolution(train_data,pit_c1)
[a,b,~]=size(train_data);
[c,d,~]=size(pit_c1);
c1_state=zeros(b-d+1,a-c+1);
for i=1:b-d+1
    for j=1:a-c+1
        c1_state(i,j)=sum(sum(train_data(i:i+c-1,j:j+d-1).*pit_c1));
    end
end
end