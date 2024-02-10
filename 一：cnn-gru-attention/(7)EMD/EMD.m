%--------------- Preparation
clear all;
close all;
clc;

y=xlsread('shiyanyi.xlsx');%原始

% 
% Nstd = 0.2; % 噪声标准差
% NE = 100;   % 集合数量
% MaxIter=500;
% 应用 EEMD
% 注意：这里假设你已经有了 eemd 的实现代码
imfs = eemd(y, 100,0.2,7);

% 可视化结果
numIMFs = size(imfs, 2);
for i = 1:numIMFs
    subplot(numIMFs, 1, i);
    plot(imfs(:, i));
    title(['IMF ', num2str(i)]);
end


% 
% % Time Domain 0 to T
% T = 1000;
% fs = 1/T;
% t = (1:T)/T;
% freqs = 2*pi*(t-0.5-1/T)/(fs);
% % center frequencies of components
% f_1 = 100;
% %f_2 = 24;
% %f_3 = 288;
% % modes
% v_1 = y1;%(cos(2*pi*f_1*t));
% %v_2 = 1/4*(cos(2*pi*f_2*t));
% %v_3 = 1/16*(cos(2*pi*f_3*t));
% % for visualization purposes
% wsub{1} = 2*pi*f_1;
% %wsub{2} = 2*pi*f_2;
% %wsub{3} = 2*pi*f_3;
% % composite signal, including noise
% f = v_1 + 0.1*randn(size(v_1));
% % some sample parameters for VMD
% alpha = 221;        % moderate bandwidth constraint适合的带宽限制
% tau = 0;            % noise-tolerance (no strict fidelity enforcement)
% K =3;              % 3 modes(分解的模态数)
% DC = 0;             % no DC part imposed（直流分量）
% init = 1;           % initialize omegas uniformly（初始化中心频率）
% tol = 1e-7;         %收敛准则容忍度；通常在1e-6左右
% 
% 
% %---------------run EMD code
% imf = emdcode(f);
% 
% figure;
% subplot(size(imf,1)+1,2,1);
% plot(t,f,'k');
% grid on;
% title('EMD分解');
% subplot(size(imf,1)+1,2,2);
% plot(freqs,abs(fft(f)),'k');
% grid on;
% title('对应频谱','FontName','宋体');
% for i = 2:size(imf,1)+1
%     subplot(size(imf,1)+1,2,i*2-1);
%     plot(t,imf(i-1,:),'k');grid on;
%     subplot(size(imf,1)+1,2,i*2);
%     plot(freqs,abs(fft(imf(i-1,:))),'k');grid on;
% end
