%% newff注释
% net = newff(P,T,S)                             % 这两种定义都可以
% net = newff(P,T,S,TF,BTF,BLF,PF,IPF,OPF,DDF)
% 1
% 2
% 　　 P：输入参数矩阵。(RxQ1)，其中Q1代表R元的输入向量。其数据意义是矩阵P有Q1列，每一列都是一个样本，而每个样本有R个属性（特征）。一般矩阵P需要归一化，即P的每一行都归一化到[0 1]或者[-1 1]。 
% 　　T：目标参数矩阵。(SNxQ2)，Q2代表SN元的目标向量。 
% 　　S：N-1个隐含层的数目（S（i）到S（N-1）），默认为空矩阵[]。输出层的单元数目SN取决于T。返回N层的前馈BP神经网络 
% 　　 TF：相关层的传递函数，默认隐含层为tansig函数，输出层为purelin函数。 
% 　　BTF：BP神经网络学习训练函数，默认值为trainlm函数。 
% 　　BLF：权重学习函数，默认值为learngdm。 
% 　　PF：性能函数，默认值为mse，可选择的还有sse，sae，mae，crossentropy。 
% 　　IPF，OPF，DDF均为默认值即可。 
% 　　例子：
% 
% net = newff( input,output, [50] , { 'logsig' 'purelin' } , 'traingdx' ) ;    
% 1
% 2，传递函数TF 
% 　　purelin： 线性传递函数。 
% 　　tansig ：正切S型传递函数。 
% 　　logsig ：对数S型传递函数。　 
% 　　隐含层和输出层函数的选择对BP神经网络预测精度有较大影响，一般隐含层节点转移函数选用 tansig函数或logsig函数，输出层节点转移函数选用tansig函数或purelin函数。 
% ３，学习训练函数BTF 
% 　　traingd：最速下降BP算法。 
% 　　traingdm：动量BP算法。 
% 　　trainda：学习率可变的最速下降BP算法。 
% 　　traindx：学习率可变的动量BP算法。 
% 　　trainrp：弹性算法。 
% 　　变梯度算法： 
% 　　　　traincgf（Fletcher-Reeves修正算法） 
% 　　　　 traincgp（Polak_Ribiere修正算法） 
% 　　　　 traincgb（Powell-Beale复位算法） 
% 　　　　 trainbfg（BFGS 拟牛顿算法） 
% 　　　　 trainoss（OSS算法）
% 
% ４，参数说明 
% 　　通过net.trainParam可以查看参数 
% 　　 Show Training Window Feedback showWindow: true 
% 　　 Show Command Line Feedback showCommandLine: false 
% 　　 Command Line Frequency show: 两次显示之间的训练次数 
% 　　Maximum Epochs epochs: 训练次数 
% 　　 Maximum Training Time time: 最长训练时间（秒） 
% 　　 Performance Goal goal: 网络性能目标 
% 　　 Minimum Gradient min_grad: 性能函数最小梯度 
% 　　 Maximum Validation Checks max_fail: 最大验证失败次数 
% 　　 Learning Rate lr: 学习速率 
% 　　Learning Rate Increase lr_inc: 学习速率增长值 
% 　　Learning Rate lr_dec: 学习速率下降值 
% 　　 Maximum Performance Increase max_perf_inc: 
% 　　 Momentum Constant mc: 动量因子