function [imfs, residuals] = EEMD(signal, ensemble_size, noise_amplitude, num_siftings)
% EEMD函数用于处理信号分解，返回多组IMF和残差项
% 输入参数:
% signal: 要处理的信号，为一维列向量
% ensemble_size: 分解时的噪音扰动次数，默认为100
% noise_amplitude: 噪音标准差，默认为0.2
% num_siftings: IMF分解过程中的sifting次数，默认为4
% 输出参数:
% imfs: IMF分解后得到的每层振动模式函数，为二维矩阵
% residuals: IMF分解后得到的每层残差项，为列向量

% 预处理
if nargin < 4 % 设置默认值
    num_siftings = 4;
end
if nargin < 3
    noise_amplitude = 0.2;
end
if nargin < 2
    ensemble_size = 100;
end
nsamples = length(signal); % 信号长度
imfs = zeros(nsamples, num_siftings+1); % 存放IMFs
residuals = signal(:); % 存放残差项

% EEMD分解过程
for n = 1:num_siftings+1 % 从1开始是因为最后一层IMF可以看做是残差项
    % 噪音扰动
    for k = 1:ensemble_size
        noise = noise_amplitude * randn(nsamples, 1); % 产生高斯白噪音
        noised_signal = signal + noise; % 噪声加到原始信号上
        % 一次分解
        [imf, residual] = SiftingProcess(noised_signal, n); % Sifting过程
        imfs(:, n) = imfs(:, n) + imf;
        residuals = residuals - residual;
    end
    imfs(:, n) = imfs(:, n) / ensemble_size; % 取平均值
end
imfs = imfs(:, 1:end-1); % 去掉最后一层噪声残差层
end

function [imf, residual] = SiftingProcess(signal, num_siftings)
% SiftingProcess函数对信号进行IMF分解，得到一组IMF和残差项
% 输入参数：
% signal: 要分解的信号，为一维列向量
% num_siftings: IMF分解过程中的sifting次数
% 输出参数：
% imf: IMF分解后的局部振动函数，为一维列向量
% residual: 残差项，为一维列向量

imf = zeros(size(signal));
residual = signal;
for i = 1:num_siftings
    % 上限/下限包络线
    upper = max(residual); % 上限包络线
    lower = min(residual); % 下限包络线
    mean_line = (upper + lower) / 2;
    % 平滑处理
    upper_diff = [0; diff(upper)]; % 上限差分
    lower_diff = [0; diff(lower)]; % 下限差分
    mean_diff = [0; diff(mean_line)]; % 平均线差分
    Z = max(upper_diff, lower_diff); % 构造辅助函数Z
    Z(Z == 0) = eps; % 避免除以0
    R = (residual - mean_line) ./ Z; % 归一化后的残差项
    % 更新IMF
    imf = imf + R;
    % 新残差项更新
    residual = signal - imf;
end
end
