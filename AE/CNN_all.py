#完整的模型训练套路
import torch
import torchvision
from torch.utils.data import DataLoader
import torch.nn as nn
from torch.nn import MaxPool2d,Conv2d,Sequential,CrossEntropyLoss,Linear,Sigmoid,Flatten
from torch.utils.tensorboard import SummaryWriter
import shutil
shutil.rmtree('../logs')
train=torchvision.datasets.CIFAR10('../dataset',train=True,transform=torchvision.transforms.ToTensor())
test=torchvision.datasets.CIFAR10('../dataset',train=False,transform=torchvision.transforms.ToTensor())

#绘图工具
writer=SummaryWriter('../logs')
#打印长度
print('训练集的长度为{}\n测试集的长度为{}'.format(len(train),len(test)))

#加载数据集
traindata=DataLoader(train,batch_size=64,shuffle=True)
testdata=DataLoader(test,batch_size=64,shuffle=True)

#加载模型
class Model(nn.Module):
    def __init__(self):
        super(Model, self).__init__()
        self.model = Sequential(
            Conv2d(3, 32, kernel_size=5, padding='same'),#3*3
            MaxPool2d(kernel_size=2),
            Conv2d(32, 32, kernel_size=5, padding=2),#bn
            MaxPool2d(kernel_size=2),
            Conv2d(32, 64, kernel_size=5, padding=2),#Dropout层
            MaxPool2d(kernel_size=2),
            Flatten(),
            Linear(1024, 64),  # 64个类别
            Linear(64, 10)
        )
    def forward(self,x):
        return self.model(x)
tsy=Model()
#损失函数
loss_fun=CrossEntropyLoss()
#优化器
l_r=0.01
op=torch.optim.SGD(tsy.parameters(),lr=l_r,momentum=0.9) #momentum动量防止权重陷入局部最优
#设置训练网络参数
total_train=0 #训练次数记录
total_test=0 #测试训练次数

epoch=10 #训练轮数
for i in range(epoch):
    print('-----第{}轮训练开始----'.format(i+1))
    #训练开始
    tsy.train()
    for img,target in traindata:
        output=tsy(img)
        loss=loss_fun(output,target)
        #调优，反向回馈
        op.zero_grad()
        loss.backward()
        op.step()
        total_train+=1
        if total_train%100==0:
            print('训练次数为{}时其损失为{}'.format(total_train, loss))
            writer.add_scalar('img of loss about train_time',loss,total_train)
    #测试
    tsy.eval()
    total_true = 0  # 正确测试集个数
    total_loss=0
    with torch.no_grad():
        for img, target in testdata:
            output = tsy(img)
            loss = loss_fun(output, target)
            total_loss = total_loss + loss
            total_test+=1
            true=(output.argmax(1)==target).sum()  #横向最大的索引
            total_true=total_true+true
    print('数据集上的平均loss为{}'.format(total_loss/len(test)))
    print('正确率为{}'.format(total_true/len(testdata)))
    writer.add_scalar('img of total_loss about test_time',total_loss,total_test)
print('训练完成')
