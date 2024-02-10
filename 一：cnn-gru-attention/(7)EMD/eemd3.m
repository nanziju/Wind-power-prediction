clear
clc
% close all
% load s.mat
y1=xlsread('shiyansan.xlsx');
%% EEMD分解
Nstd = 0.5;
NR = 500;
% MaxIter = 5000;
[u its]=eemd(y1,Nstd ,NR);
t = 0:0.001:2;
% [a b]=size(u);
a = 8;
 
figure(1);
imfn=u;
subplot(a+1,1,1); 
plot(t,s); %故障信号
ylabel('s','fontsize',12,'fontname','宋体');
for n1=1:a
    subplot(a+1,1,n1+1);
    plot(t,u(n1,:));%输出IMF分量，a(:,n)则表示矩阵a的第n列元素，u(n1,:)表示矩阵u的n1行元素
    ylabel(['IMF' int2str(n1)]);%int2str(i)是将数值i四舍五入后转变成字符，y轴命名
end
 xlabel('时间\itt/s','fontsize',12,'fontname','宋体');
 %%
figure('Name','频谱图','Color','white');
 
K = a;
L = length(t);
fs = 2001;
for i = 1:K
    p=abs(fft(u(i,:))); %并fft，得到p，就是包络线的fft---包络谱 
    subplot(K,1,i);
    plot((0:L-1)*fs/L,p)   %绘制包络谱
    xlim([0 fs/2]) %展示包络谱低频段，这句代码可以自己根据情况选择是否注释
     if i ==1
    title('频谱图'); ylabel(['IMF' int2str(i)]);%int2str(i)是将数值i四舍五入后转变成字符，y轴命名
     elseif i==K
        xlabel('频率');  ylabel(['IMF' int2str(i)]);%int2str(i)是将数值i四舍五入后转变成字符，y轴命名
     else
         ylabel(['IMF' int2str(i)]);%int2str(i)是将数值i四舍五入后转变成字符，y轴命名
     end
end
set(gcf,'color','w');