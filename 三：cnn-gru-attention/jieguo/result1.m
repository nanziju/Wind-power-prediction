clear all
close all
clc

 y=xlsread('NeuralProphet-iceemdan-vmd-libsvm.xlsx');%误差修正前的16列预测结果
%y=csvread('prophet.csv');
%  x1=sum(x1,2);
%  x1=x1(791:end);


% x1=xlsread('wt1(vmd)+wt234-ibsvm.xlsx');%误差修正前的16列预测结果
% x1=sum(x1,2);
% x1=x1(791:end);
% x2=csvread('ptrain2.csv');
%  x2=sum(x2,2);
% x2=x2(801:end);
% y=x2-x1;
x=xlsread('shiyaner.xlsx');
% x=x(801:end);
%  c=y-x;


MSE_test = mean((x - y).^2);
disp(['均方误差MSE = ', num2str(MSE_test)])
MAE_test = mean(abs(x - y));
disp(['平均绝对误差MAE = ', num2str(MAE_test)])
RMSE_test = sqrt(MSE_test);
disp(['根均方误差RMSE = ', num2str(RMSE_test)])
% MAPE_test = mean(abs((x - y)./x));
% disp(['平均绝对百分比误差MAPE = ', num2str(MAPE_test*100), '%'])

  mape=sum(abs((x-y)./x))/length(x);
  disp(['平均绝对百分比误差MAPE = ', num2str(mape)])
%  mape1=100*sum(abs((x-y)./x))/size(x,1);
%  disp(['平均绝对百分比误差MAPE = ', num2str(mape1), '%'])
R_test = corrcoef(x, y);
R2_test = R_test(1, 2)^2;
disp(['拟合优度R2 = ', num2str(R2_test)])
xx=1:1:200;
TURE=x;
PREDICTION=y;
plot(xx,TURE,'-r',xx,PREDICTION,'-b')

axis([0,200,0,20])
set(gca,'XTick',[0:10:200])
set(gca,'YTick',[0:2:20])
xlabel('T period')
ylabel('Wind power (m/s)')
legend('Actual wind power','The proposed model','-r','-b')