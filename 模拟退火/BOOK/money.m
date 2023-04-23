function  out =  money(in1,in2,in3,in4)
% 输入：in1: 购买方案； in2:运费;  in3: 每本书在每家店的价格; in4：一共要购买几本书
   index = unique(in1);  % 在哪些商店购买了商品，因为我们等下要计算运费unique(A)找到不重复的A中元素
   out = sum(in2(index)); % 计算买书花费的运费
    % 计算总花费：刚刚计算出来的运费 + 五本书的售价
    for i = 1:in4
        out = out + in3(in1(i),i);  
    end
end