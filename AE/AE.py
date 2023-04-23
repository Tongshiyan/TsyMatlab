#AE自编码器
import torch
from torch.utils.data import DataLoader,Dataset
from copy import deepcopy as copy
from torch.utils.tensorboard import SummaryWriter
import torch.nn as nn
import pandas as pd
import numpy as np
import shutil
import os
class Mydata(Dataset):
    def __init__(self,rootdata):
        self.rootdata=rootdata
    def __getitem__(self, item):
        return torch.Tensor(self.rootdata[item][5:])
    def __len__(self):
        return len(self.rootdata)

#AE模型
class AE(nn.Module):
    def __init__(self,inchannel):
        super(AE, self).__init__()
        self.encoder=nn.Sequential(
            nn.Linear(inchannel,4),
            nn.Sigmoid(),
            # nn.Linear(32,16),
            # nn.ReLU(),
            # nn.Linear(16,8),
            # nn.ReLU(),
            # nn.Linear(8,4),
            # nn.ReLU()
        )
        self.decoder=nn.Sequential(
            # nn.Linear(4,8),
            # nn.ReLU(),
            # nn.Linear(8,16),
            # nn.ReLU(),
            # nn.Linear(16,32),
            # nn.ReLU(),
            nn.Linear(4,inchannel),
            nn.Sigmoid()
        )
    def forward(self,x):
        x1=self.encoder(x)
        return self.decoder(x1),x1
#归一化
def std(data):
    data1=data-np.mean(data,axis=0)
    data2=data1/np.std(data,axis=0)
    return data2
#训练过程
def train_progress(epoch):

    best_model=None #最优模型
    global best_loss
    epoch_cnt = 0
    for i in range(epoch):
        sum_loss = 0
        item=0
        for x in traindata:
            # x=x.cuda()
            y, deepy = model(x)
            loss = lossfun(y, x)
            optim.zero_grad()
            loss.backward()
            optim.step()
            sum_loss += loss
            item+=1
        writer.add_scalar('AE process', sum_loss/item, i)
        print('第{}轮训练完成,其总loss为sum_loss={}，平均loss为ave_loss={}'.format(i + 1, sum_loss,sum_loss/item))


        # 记录模型
        if best_loss > sum_loss:
            best_loss = sum_loss
            best_model = copy(model)
            epoch_cnt = 0
        else:
            epoch_cnt += 1
        # 后续的early_stop次模型都没有更好的就保存模型退出循环
        if epoch_cnt > early_stop:
            torch.save(best_model.state_dict(), './AE.pth')
            break

    torch.save(best_model.state_dict(), './AE.pth')
if __name__=='__main__':
    # 载入excel数据
    if os.path.exists('./logs'):
        shutil.rmtree('./logs')
    # 绘图工具
    writer = SummaryWriter('./logs')
    df = pd.read_excel(r'C:\Users\86187\Desktop\1traindata.xlsm')
    rootdata = std(np.array(df))
    traindata = Mydata(rootdata)
    traindata = DataLoader(dataset=traindata, batch_size=100, shuffle=False)
    print('数据集加载完毕！')
    model = AE(11)
    #model = model.cuda()
    print('模型加载完毕！')
    # 损失函数
    lossfun = nn.MSELoss()
    #lossfun = lossfun.cuda()
    # 优化器
    optim = torch.optim.SGD(model.parameters(), lr=0.1,momentum=0.5)

    early_stop=100
    best_loss=np.inf
    loss_list=[]
    epoch=2000
    train_progress(epoch)



