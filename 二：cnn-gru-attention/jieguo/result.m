clear all
close all
clc

y=xlsread('cnn-bilstm2.xlsx')';
 % x=csvread('libsvm.csv');
% x=x(2:end);
% y =x(:,1)+x(:,2)+x(:,3)+x(:,4)+x(:,5)+x(:,6)+x(:,7)+x(:,8)+x(:,9)+x(:,10)+x(:,11)+x(:,12)+x(:,13)+x(:,14)+x(:,15)+x(:,16);
% y=sum(y,2);
% x=y1+y2+y3+y4+y5+y6+y7+y8+y9+y10+y11+y12+y13;
% Y=load('imf1.mat')+load('imf2.mat')load('imf3.mat')load('imf4.mat')load('imf5.mat')load('imf6.mat')load('imf7.mat')load('imf8.mat')load('imf9.mat')load('imf10.mat')load('imf11.mat')load('imf12.mat')load('imf13.mat');
x=xlsread('shiyaner1.xlsx');
     x=x(801:end);
% y=sum(y,2);
% x2=x2(793:end);
% Y2=Y(165:end);
%  c=y-x;

MSE_test = mean((x - y).^2);
disp(['均方误差MSE = ', num2str(MSE_test)])
MAE_test = mean(abs(x - y));
disp(['平均绝对误差MAE = ', num2str(MAE_test)])
RMSE_test = sqrt(MSE_test);
disp(['根均方误差RMSE = ', num2str(RMSE_test)])
  mape=sum(abs((y-x)./y))/length(y);
  disp(['平均绝对百分比误差MAPE = ', num2str(mape)])
% MAPE_test = mean(abs((x - y)./x));
% disp(['平均绝对百分比误差MAPE = ', num2str(MAPE_test*100), '%'])
R_test = corrcoef(x, y);
R2_test = R_test(1, 2)^2;
disp(['拟合优度R2 = ', num2str(R2_test)])
xx=1:1:190;
TURE=x;
PREDICTION=y;
plot(xx,TURE,'-r',xx,PREDICTION,'-g');

axis([0,190,0,70])
set(gca,'XTick',[0:20:190])
set(gca,'YTick',[0:6:70])
xlabel('T period')
ylabel('Wind power (m/s)')
