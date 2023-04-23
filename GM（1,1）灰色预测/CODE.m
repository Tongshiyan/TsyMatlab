%% GM(1,1)灰色预测模型 
%输入变量为行向量
%依据时间的连续变化给出的预测模型
%% 初始化
clear;clc
load x.mat;
%% 判断是否存在非负序列
y0=x(:,1)';   %*****输入预测的变量
n=length(y0);
er=0;%错误指标出错就置1
%判断是否有非负元素
if sum(y0<0)>0
    disp('存在负数，无法进行灰色预测')
    er=1;
end

%% 进行准指数规律检验
egh=0;%判断是否通过准指数规律检验的指标
if er==0
    disp('准指数规律检验')
    y1=cumsum(y0);
    gh=y0(2:end)./y1(1:end-1);
    disp(strcat('type1：光滑比小于0.5的数据占比为',num2str(100*sum(gh<0.5)/(n-1)),'%'))
    disp(strcat('type2：除去前两个时期外，光滑比小于0.5的数据占比为',num2str(100*sum(gh(3:end)<0.5)/(n-3)),'%'))
    if 100*sum(gh<0.5)/(n-1)<60 || 100*sum(gh(3:end)<0.5)/(n-3)<90
        egh=1;
    end
end

if egh==0
    disp("通过准指数规律检验")
else
     disp("没有通过准指数规律检验")
end
%% 利用试验组来选择使用传统的GM(1,1)模型、新信息GM(1,1)模型还是新陈代谢GM(1,1)模型
if er==0&&egh==0
    if n>7
        test=3;
    else
        test=2;
    end
    train=y0(1:end-test);
    testnum=y0(end-test+1:end);
    disp('----------------------------分割线--------------------------------')
    %传统GM（1,1）模型
    disp('传统GM（1,1）模型')
    return0 = gm11(train,test)
    disp('----------------------------分割线--------------------------------')
    disp('新信息GM（1,1）模型')
    return1 = newgm11(train,test)
    disp('----------------------------分割线--------------------------------')
    disp('新陈代谢GM（1,1）模型')
    return2 = xcdxgm11(train,test)
    disp('----------------------------分割线--------------------------------')
    % 现在比较三种模型对于试验数据的预测结果
    % 计算误差平方和SSE
        SSE1 = sum((testnum-return0).^2);
        SSE2 = sum((testnum-return1).^2);
        SSE3 = sum((testnum-return2).^2);
        disp(strcat('传统GM(1,1)对于试验组预测的SSE为',num2str(SSE1)))
        disp(strcat('新信息GM(1,1)对于试验组预测的SSE为',num2str(SSE2)))
        disp(strcat('新陈代谢GM(1,1)对于试验组预测的SSE为',num2str(SSE3)))
end
        %% 下面选用SSE最小的模型进行预测
         if SSE1<SSE2
            if SSE1<SSE3
                want = 1;  % SSE1最小，选择传统GM(1,1)模型
            else
                want = 3;  % SSE3最小，选择新陈代谢GM(1,1)模型
            end
        elseif SSE2<SSE3
            want = 2;  % SSE2最小，选择新信息GM(1,1)模型
        else
            want = 3;  % SSE3最小，选择新陈代谢GM(1,1)模型
         end
       M = {'传统GM(1,1)模型','新信息GM(1,1)模型','新陈代谢GM(1,1)模型'};
       disp(strcat('选用',M(want),'进行预测'))
       disp('----------------------------分割线--------------------------------')
       
       %% 开始预测
       disp('需要往后面预测的期数： ')
        predict = 3
        [out1,out2,out3,out4] = gm11(y0, predict);  % 先利用gm11函数得到对原数据的拟合结果
          %判断我们选择的模型，如果是2或3，则更新刚刚由模型1计算出来的预测结果
        if want == 2
            out1 = newgm11(y0, predict);
        end
        if want == 3
            out1 = xcdxgm11(y0, predict);
        end

         disp('----------------------------分割线--------------------------------')
    out1
         %% 残差检验
    average0 = mean(out3);  % 计算平均相对残差 mean函数用来均值
    disp(strcat('平均相对残差为',num2str(average0)))
    if average0<0.1
        disp('拟合程度非常不错')
    elseif average0<0.2
        disp('拟合程度达到一般要求')
    else
        disp('拟合程度不太好')
    end
     disp('----------------------------分割线--------------------------------')
        %% 级比偏差检验
    average1 = mean(out4);   % 计算平均级比偏差
    disp(strcat('平均级比偏差为',num2str(average1)))
    if average1<0.1
        disp('拟合程度非常不错')
    elseif average1<0.2
        disp('拟合程度达到一般要求')
    else
        disp('拟合程度不太好')
    end

