%--------------- Preparation
clear all;
close all;
clc;
%load error1;
X=xlsread('17-06-25imf18');   %分解原序列
X=X(:,1);
y1=X(1:1000);

% Time Domain 0 to T
T =500;
fs = 1/T;
t = (1:T)/T;
freqs = 2*pi*(t-0.5-1/T)/(fs);
% center frequencies of components
f_1 = 1005;
%f_2 = 24;
%f_3 = 288;
% modes
v_1 = y1;%(cos(2*pi*f_1*t));
%v_2 = 1/4*(cos(2*pi*f_2*t));
%v_3 = 1/16*(cos(2*pi*f_3*t));
% for visualization purposes
wsub{1} = 2*pi*f_1;
%wsub{2} = 2*pi*f_2;
%wsub{3} = 2*pi*f_3;
% composite signal, including noise
f = v_1 + 0.1*randn(size(v_1));
% some sample parameters for VMD
alpha = 1005;        % moderate bandwidth constraint适合的带宽限制
tau = 0;            % noise-tolerance (no strict fidelity enforcement)
K = 16;              % 3 modes(分解的模态数)
DC = 0;             % no DC part imposed（直流分量）
init = 1;           % initialize omegas uniformly（初始化中心频率）
tol = 1e-7;         %收敛准则容忍度；通常在1e-6左右
 
%--------------- Run actual VMD code
[u, u_hat, omega] = VMD(f, alpha, tau, K, DC, init, tol);
subplot(size(u,1)+1,1,1);%函数，将多个图画到一个平面上的工具
plot(t,f,'r');%二维线画图函数
grid on;
title('VMD分解','FontName','宋体');

% subplot(size(u,1)+1,2,2);
% plot(freqs,abs(fft(f)),'k');
% grid on;
% title('对应频谱','FontName','宋体');
for i = 2:size(u,1)+1
    subplot(size(u,1)+1,1,i*2-1);
    plot(t,u(i-1,:),'b');
    grid on;
%     subplot(size(u,1)+1,2,i*2);
%     plot(freqs,abs(fft(u(i-1,:))),'k');grid on;
end