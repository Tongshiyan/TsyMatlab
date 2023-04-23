%压缩主函数程序
% pa为图片路径，save为保存路径，r为压缩特征比例既压缩系数
%gray表示执行是否把彩色图片转换为灰色图片
function []= photocompress(pa,save,r,gray)
if nargin==3
    gray=0;
end
img=double(imread(pa));
if (gray==1) && (size(img,3)==3)
    img=double(rgb2gray(imread(pa)));%imread()只能用源文件路径，不能使用img
end
if size(img,3)==3
    R=img(:,:,1);
    G=img(:,:,2);
    B=img(:,:,3);
    disp(['正在对',pa,'的红色要素进行压缩'])
    r=mysvd(R,r);
    disp(['正在对',pa,'的绿色要素进行压缩'])
    g=mysvd(G,r);
    disp(['正在对',pa,'的蓝色要素进行压缩'])
    b=mysvd(B,r);
    newimg=cat(3,r,g,b);
else
        disp(['正在对',pa,'进行灰色图片压缩'])
    newimg=mysvd(img,r);
end
imshow(uint8(newimg));
imwrite(uint8(newimg),save);
disp('压缩完成')
end
    
    