import torch
import pandas as pd
import numpy as np
import AE
model=AE.AE(11)
model.load_state_dict(torch.load('./AE.pth'),False)
df=pd.read_excel(r'C:\Users\86187\Desktop\1traindata.xlsm')
rootdata = AE.std(np.array(df))
traindata = AE.Mydata(rootdata)
traindata=AE.DataLoader(traindata,batch_size=1,shuffle=False)
list1=[]
list2=[]
list3=[]
list4=[]
for data in traindata:
    a,b=model(data)
    b=b.detach().numpy()
    list1.append(b[0][0])
    list2.append(b[0][1])
    list3.append(b[0][2])
    list4.append(b[0][3])

df1=pd.DataFrame({'F1':list1,
                  'F2':list2,
                  'F3':list3,
                  'F4':list4
                  })
df1.to_excel('./out.xlsm',index=False)