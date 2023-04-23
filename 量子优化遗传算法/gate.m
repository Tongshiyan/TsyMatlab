%% 量子旋转门调整策略
% 输入  chr：更新前的量子比特编码
%     fitness：适应度值
%        best：当前种群中最优个体
%      bin：二进制编码
% 输出  chr：更新后的量子比特编码
function chr=gate(chr,fitness,best,bin)
size_pop=size(chr,1)/2;
len_chr=size(bin,2);
for i=1:size_pop
    for j=1:len_chr
        alpha=chr(2*i-1,j);   % α自旋向上
        beta=chr(2*i,j);     % β自旋向上
        x=bin(i,j);
        b=best.bin(j);
        if ((x==0)&&(b==0))||((x==1)&&(b==1))
            delta=0;                  % delta为旋转角的大小
            s=0;                        % s为旋转角的符号，即旋转方向
        elseif (x==0)&&(b==1)&&(fitness(i)<best.fitness)
            delta=0.01*pi;
            if alpha*beta>0
                s=1;
            elseif alpha*beta<0
                s=-1;
            elseif alpha==0
                s=0;
            elseif beta==0
                s=sign(randn);
            end
        elseif (x==0)&&(b==1)&&(fitness(i)>=best.fitness)
            delta=0.01*pi;
            if alpha*beta>0
                s=-1;
            elseif alpha*beta<0
                s=1;
            elseif alpha==0
                s=sign(randn);
            elseif beta==0
                s=0;
            end
        elseif (x==1)&&(b==0)&&(fitness(i)<best.fitness)
            delta=0.01*pi;
            if alpha*beta>0
                s=-1;
            elseif alpha*beta<0
                s=1;
            elseif alpha==0
                s=sign(randn);
            elseif beta==0
                s=0;
            end
        elseif (x==1)&&(b==0)&&(fitness(i)>=best.fitness)
            delta=0.01*pi;
            if alpha*beta>0
                s=1;
            elseif alpha*beta<0
                s=-1;
            elseif alpha==0
                s=0;
            elseif beta==0
                s=sign(randn);
            end
        end
        e=s*delta;       % e为旋转角
        U=[cos(e) -sin(e);sin(e) cos(e)];      % 量子旋转门
        y=U*[alpha beta]';        % y为更新后的量子位
        chr(2*i-1,j)=y(1);
        chr(2*i,j)=y(2);
    end
end