% 假设的真实值和预测值

y_true                = xlsread('shiyansan.xlsx');


y_pred      = xlsread('LSTM3.xlsx');
% y_pred              =xlsread('CNN.xlsx');
% y_pred       = xlsread('GRU.xlsx');
% y_pred      =xlsread('cnn-gru3.xlsx');
% y_pred       =xlsread('CNN-GRU-Attention.xlsx');




% y_pred         =xlsread('vmd-cnn-gru-attention.xlsx');
% y_pred       = xlsread('iceemdan-cnn-gru-Attention.xlsx');
% y_pred    = xlsread('iceemdan-cnn-gru-attention-ARIMA.xlsx');
% y_pred     =xlsread('vmd-cnn-gru-attention-ARIMA.xlsx');
% y_pred    =xlsread('vmd-cnn-gru-attention-vmd-ARIMA.xlsx');
% 分位数
tau = 0.5; % 例如，使用中位数

% 初始化弹球损失
pinball_loss = 0;

% 计算弹球损失
n = length(y_true);
for i = 1:n
    if y_true(i) > y_pred(i)
        pinball_loss = pinball_loss + tau * (y_true(i) - y_pred(i));
    else
        pinball_loss = pinball_loss + (1 - tau) * (y_pred(i) - y_true(i));
    end
end

% 计算平均弹球损失
pinball_loss = pinball_loss / n;

% 输出结果
fprintf('平均弹球损失: %f\n', pinball_loss);
