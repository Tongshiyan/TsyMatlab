%% 方法作用
%  K-交叉验证是指将原始数据分成K组(一般是均分)，将每个子集数据分别做一次验证集，
%  其余的K-1组子集数据作为训练集，这样会得到K个模型，用这K个模型最终的验证集的分类
%  准确率的平均数作为此K-CV下分类器的性能指标。K一般大于等于2，实际操作时一般从3开始取
%  ，只有在原始数据集合数据量小的时候才会尝试取2.。而K-CV 的实验共需要建立 k 个models，
%  并计算 k 次 test sets 的平均辨识率。在实作上，k 要够大才能使各回合中的 训练样本数够多，
%  一般而言 k=10 (作为一个经验参数)算是相当足够了。
%  K-交叉验证常用来确定不同类型的模型哪一种更好，为了减少数据划分对模型产生的影响 ，最
%  终选取的模型类型是通过K次建模的误差平均值最小的模型。当k较大时，经过更多次数的平均可以学
%  习得到更符合真实数据分布的模型，Bias就小了，但是这样一来模型就更加拟合训练数据集，再去
%  测试集上预测的时候预测误差的期望值就变大了，从而Variance就大了；反之，k较小时模型不会过
%  度拟合训练数据，从而Bias较大，但是正因为没有过度拟合训练数据，Variance也较小。（参考听风1996 简书）
