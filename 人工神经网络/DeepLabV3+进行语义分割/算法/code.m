%% 深度学习网络DeepLabV3+进行语义分割
clc;clear
%data1-6为训练集，data7为测试集
%% 裁剪分割图像（在算法的文件夹下运行）分割成四张图
for i=1:6
    A=imread(['Data' num2str(i) '.png']);
    a1=imcrop(A,[0,0,300,250]);
    a2=imcrop(A,[301,0,300,250]);
    a3=imcrop(A,[0,251,300,250]);
    a4=imcrop(A,[301,251,300,250]);
    img1={a1 a2 a3 a4};
for j=1:4
    img2=img1(j);
    img3=img2{1,1};
    imwrite(img3,[num2str(i),'-',num2str(j),'.png']);
end
end
%% 裁剪原始标签图像分割成四张图
for i=1:6
    A=imread(['Data' num2str(i) '_reference.png']);
    a1=imcrop(A,[0,0,300,250]);
    a2=imcrop(A,[301,0,300,250]);
    a3=imcrop(A,[0,251,300,250]);
    a4=imcrop(A,[301,251,300,250]);
    img={a1 a2 a3 a4};

   for j=1:4
       I=img(j);
       I=I{1,1};
       itmp=I(:,:,1);
       width=size(I);
      for m=1:width(1)
       for n=1:width(2)
        if I(m,n,1)==0&&I(m,n,2)==0&&I(m,n,3)==0 %三通道均为0的是背景
            itmp(m,n)=0;
        else
            itmp(m,n)=1;             %否则是耕地
        end
       end
      end
      imwrite(itmp,[num2str(i),'-',num2str(j),'.png'])
   end
end
%% 神经网络输入
clc;clear
close all;
data=fullfile('..\');%返回到总文件夹
save_train_img=fullfile([data,'裁剪原图']);%文件路径
save_train_label=fullfile([data,'裁剪标签图']);

train_img = imageDatastore(save_train_img);% 加载训练图像
name=["back" "farmland"];%类别名称
labelid=[0 1];%设置类别编号
pxds = pixelLabelDatastore(save_train_label,name,labelid);%生成相应的类别标签

%以下程序用于看一下效果
% Read image and pixel label data.
A = readimage(train_img,5);%选中第5号图片
C = readimage(pxds,5);%选中第5号标签
% Display the label categories in C
% categories(C{1})
cmap = ColorMap;
% Overlay pixel label data on the image and display.
B = labeloverlay(A, C,'ColorMap',cmap,'Transparency',0);
figure
imshow(B)
%结束
%% DeepLabV3+模型构建
tbl = countEachLabel(pxds);
frequency = tbl.PixelCount/sum(tbl.PixelCount);
bar(1:numel(name),frequency)
xticks(1:numel(name)) 
xticklabels(tbl.Name)
xtickangle(45)
ylabel('Frequency')%计算总个数和背景像素总个数之比，用于更改输出层的权重

%制作 DeepLabV3+
imagesize=[250 300 3];%图像大小
num_id=numel(name);%类别数量
%构建deeplabV3+.
lgraph = deeplabv3plusLayers(imagesize, num_id, "mobilenetv2");
%设置类别权重
imagefreq = tbl.PixelCount ./ tbl.ImagePixelCount;
classweights = median(imagefreq) ./ imagefreq;
pxLayer = pixelClassificationLayer('Name','labels','Classes',tbl.Name,'ClassWeights',classweights);
lgraph = replaceLayer(lgraph,"classification",pxLayer);

%% 模型的训练和验证
% 设置训练参数
options = trainingOptions('adam', ...%选取adam优化器
    'LearnRateSchedule','piecewise',...
    'LearnRateDropPeriod',20,...%学习率每20代降低一次
    'LearnRateDropFactor',0.4,...%学习率每20代降低0.4
    'InitialLearnRate',1e-4, ...%初始学习率
    'L2Regularization',0.005, ...
    'MaxEpochs',20, ...  %最大迭代次数
    'MiniBatchSize',8, ...%小批量尺寸，可根据显存更改，这里用的8g显存
    'Shuffle','every-epoch', ...
    'VerboseFrequency',2,...
    'Plots','training-progress');%绘制训练曲线
% 图像增强，
augmenter = imageDataAugmenter('RandXReflection',true,...
    'RandXTranslation',[-10 10],'RandYTranslation',[-10 10]);%进行平移和翻转
pximds = pixelLabelImageDatastore(train_img,pxds, ...
    'DataAugmentation',augmenter);

% 训练网络
[net,info] = trainNetwork(pximds,lgraph,options);
disp('训练完成')
%% 模型的验证
% 动态显示  训练集数据
cmap = ColorMap;    
imagePath=pwd;
imageFiles = dir(imagePath); %%读取目录文件下的所有图片文件  
numFiles = length(imageFiles);%%获取图片的数量 
figure()
for i = 3:numFiles
    j = i-2; 
    subplot(1,2,1)
    imageFile = strcat(imagePath,'\',imageFiles(i).name);
    I = imread(imageFile);
    imshow(I,[],'parent',gca)
    subplot(1,2,2)
    C = semanticseg(I, net);
    B = labeloverlay(I,C,'Colormap',cmap,'Transparency',0);
    imshow(B,[],'parent',gca)

%     pixelLabelColorbar(cmap, classes);
    pause(2)
end
%% 测试集训练
cmap = ColorMap; 
img_test=imread('Data7.png');
img_test_reference=imread('Data7_reference.png');
    a1=imcrop(img_test,[0,0,300,250]);
    a2=imcrop(img_test,[301,0,300,250]);
    a3=imcrop(img_test,[0,251,300,250]);
    a4=imcrop(img_test,[301,251,300,250]);
    a5=imcrop(img_test_reference,[0,0,300,250]);
    a6=imcrop(img_test_reference,[301,0,300,250]);
    a7=imcrop(img_test_reference,[0,251,300,250]);
    a8=imcrop(img_test_reference,[301,251,300,250]);
figure
subplot(1,3,1);
imshow(a4);
subplot(1,3,2);
test=semanticseg(a4,net);
test_label=labeloverlay(a4,test,'Colormap',cmap,'Transparency',0);
imshow(test_label)
subplot(1,3,3);
imshow(a8)
title('测试结果对比')

