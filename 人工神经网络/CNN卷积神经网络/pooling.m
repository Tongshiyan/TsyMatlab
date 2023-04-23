%% 池化操作
function s1_state=pooling(c1_state,pooling_init)
[a,b,~]=size(c1_state);
[c,d,~]=size(pooling_init);
s1_state=zeros(b/d,a/c);
for i=1:b/d
    for j=1:a/c
        s1_state(i,j)=sum(sum(c1_state(2*i-1:2*i,2*j-1:2*j).*pooling_init));
    end
end
end