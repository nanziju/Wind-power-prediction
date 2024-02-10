

% 假设我们有七个模型的预测结果

orignal                = xlsread('shiyaner.xlsx');
p1     = xlsread('LSTM2.xlsx');
p2           =xlsread('CNN.xlsx');
p3     = xlsread('GRU.xlsx');
p4   = xlsread('BILSTM2.xlsx');
p5    =  xlsread('cnn-bilstm2.xlsx');
p6 = xlsread('cnn-gru2.xlsx');
p7 = xlsread('CNN-GRU-Attention.xlsx');

% 将所有结果合并为一个矩阵
allResults = [orignal,p1,p2,p3,p4,p5,p6,p7];

% 绘制箱线图
figure;
boxplot(allResults, 'Labels', {'Actual Wind Power','LSTM','CNN','GRU','BILSTM','CNN-BILSTM','CNN-GRU','CNN-GRU-Attention'});

ax = gca;

% 设置坐标轴的字体名称、大小和样式
set(ax, 'FontName', 'Times New Roman', 'FontSize', 10, 'FontAngle', 'italic');
hold on;

% 绘制蜂群图
for i = 1:size(allResults, 2)
    % 为每个数据点计算随机偏移量
    x = (1:size(allResults, 2)) + 0.1 * randn(size(allResults, 1), 1);
    % 绘制蜂群图的数据点
    scatter(x(:, i), allResults(:, i), 'filled');
end

hold off;
title('Comparison of Model Predictions ( Date 2 )','FontName','Times New Roman','FontAngle','italic');
ylabel('Prediction Values','FontName','Times New Roman','FontAngle','italic');
xlabel('','FontName','Times New Roman','FontAngle','italic');

% 自定义函数不再需要，因为我们已经在上面的循环中实现了蜂群图的绘制
