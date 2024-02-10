

% 假设我们有七个模型的预测结果

orignal                = xlsread('shiyaner.xlsx');
p1= xlsread('EMD-cnn-gru-attention.xlsx');
p2= xlsread('eemd-cnn-gru-Attention.xlsx');
p3= xlsread('iceemdan-cnn-gru-Attention.xlsx');
p4          =xlsread('vmd-cnn-gru-attention.xlsx');
p5    = xlsread('iceemdan-cnn-gru-attention-ARIMA.xlsx');
p6     =xlsread('vmd-cnn-gru-attention-ARIMA.xlsx');
p7     =xlsread('vmd-cnn-gru-attention-vmd-ARIMA.xlsx');
% ... 相同方式定义 model3Results 到 model7Results

% 将所有结果合并为一个矩阵

allResults = [orignal,p1,p2,p3,p4,p5,p6,p7];
% 绘制箱线图
figure;

boxplot(allResults, 'Labels', {'Actual Wind Power','EMD-CNN-GRU-Attention','EEMD-CNN-GRU-Attention','ICEEMDAN-CNN-GRU-Attention','VMD-CNN-GRU-Attention','ICEEMDAN-CNN-GRU-Attention-Arima','VMD-CNN-GRU-Attention-Arima','VMD-CNN-GRU-Attention-VMD-Arima'});
ax = gca;
% 设置坐标轴的字体名称、大小和样式
 set( ax, 'FontName', 'Times New Roman', 'FontSize', 14, 'FontAngle', 'italic');
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
