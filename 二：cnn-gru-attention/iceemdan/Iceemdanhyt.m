clear all;
close all;
clc;
y=xlsread('shiyanyi.xlsx');
y=y(:,1);
y=y(1:1000);

% Nstd = 0.2;
% NR = 500;
% MaxIter = 5000;

[modes its]=eemd(y,0.2,500,5000);
t=1:length(y);

[a b]=size(modes);
subplot(a+1,1,1);
plot(t,y,'r');
grid on;
title('iceemdan分解');

for i=2:a+1
    subplot(a+1,1,i);
   % plot(t,modes(i-1,:));
       plot(t,modes(i-1,:),'b');
    ylabel (['IMF ' num2str(i-1)]);%标签
    set(gca,'xtick',[])
    xlim([1 length(y)])%设置x的上下限。
end
