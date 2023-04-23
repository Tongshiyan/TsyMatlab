function out = newway(in1, in2, in3)
% in1：原来的买书方案，是一个1*in3的向量，每一个元素都位于1-in2之间
        index =  randi([1, in3],1) ;  % 看哪一本书要更换书店购买
        out= in1;  % 将原来的方案赋值给out
        out(index) = randi([1, in2],1);  % 将in1中的第index本书换一个书店购买   
end
