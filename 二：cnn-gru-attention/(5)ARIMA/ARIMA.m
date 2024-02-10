clear;
%data=xlsread('2003');
%data=data(:,1);
%Data=data(1:249);

for t=1:11
y=xlsread('error-vmd.xlsx');
y=y(:,t);
%初始数据的录入
Data=y;

%load test(lorenz63)
%Data=data(:,1);

%data=xlsread('Arou');
%data=data(:,7);
%Data=data(1:1000);



SourceData=Data(1:190);%取1800-2000个数据
step=1;
TempData=SourceData;
TempData=detrend(TempData);%消除时间序列中的线性趋势项
TrendData=SourceData-TempData;%真实值减去线性趋势  非线性部分
%--------差分，平稳化时间序列---------
H=adftest(TempData);
difftime=0;
SaveDiffData=[];
while ~H
SaveDiffData=[SaveDiffData,TempData(1,1)];
TempData=diff(TempData); %差分，平稳化时间序列
difftime=difftime+1; %差分次数
H=adftest(TempData); %adf检验，判断时间序列是否平稳化
end
%---------模型定阶或识别--------------
u = iddata(TempData);
test = [];
for p = 0:10%自回归对应PACF,给定滞后长度上限p和q，一般取为T/10、ln(T)或T^(1/2),这里取T/10=12
  for q = 0:10 %移动平均对应ACF
    m = armax(u,[p q]);
    AIC = aic(m); %armax(p,q),计算AIC
    test = [test;p q AIC];
 end
end


for k = 1:size(test,1)
   if test(k,3) == min(test(:,3)) %选择AIC值最小的模型
      p_test = test(k,1);
      q_test = test(k,2);
      break;
   end
end
%------1阶预测-----------------
TempData=[TempData;zeros(step,1)];
n=iddata(TempData);
m = armax(u,[p_test q_test]);
%m = armax(u(1:ls),[p_test q_test]);
%armax(p,q),[p_test q_test]对应AIC值最小，自动回归滑动平均模型
P1=predict(m,n,1);
PreR=P1.OutputData;
PreR=PreR';
%----------还原差分-----------------
if size(SaveDiffData,2)~=0
   for index=size(SaveDiffData,2):-1:1
      PreR=cumsum([SaveDiffData(index),PreR]);
    end
end
%-------------------预测趋势并返回结果----------------
mp1=polyfit([1:size(TrendData',2)],TrendData',1);
xt=[];
for j=1:step
   xt=[xt,size(TrendData',2)+j];
end
TrendResult=polyval(mp1,xt);
PreData=TrendResult+PreR(size(SourceData',2)+1:size(PreR,2));
tempx=[TrendData',TrendResult]+PreR; % tempx为预测结果
tempx=tempx(1:190)';
%计算相对误差
mse=MSE1(tempx,Data(1:190));
y_arima=tempx';
plot(tempx,'r');         %红色为预测值图象
hold on
plot(Data(1:190),'b')%蓝色为观测值图像
legend('预测输出','期望输出')
y_arima=y_arima(1:190)';
y_test=Data(1:190);
rmse1 = sqrt(mean((y_arima-y_test).^2));
%re=y_arima-y_test;

 MSE_test = mean((y_arima - y_test).^2);
disp(['均方误差MSE = ', num2str(MSE_test)])
MAE_test = mean(abs(y_arima - y_test));
disp(['平均绝对误差MAE = ', num2str(MAE_test)])
RMSE_test = sqrt(MSE_test);
disp(['根均方误差RMSE = ', num2str(RMSE_test)])
  mape=sum(abs((y_arima-y_test)./y_arima))/length(y_arima);
  disp(['平均绝对百分比误差MAPE = ', num2str(mape)])
% MAPE_test = mean(abs((y_arima - y_test)./y_arima));
% disp(['平均绝对百分比误差MAPE = ', num2str(MAPE_test*100), '%'])
R_test = corrcoef(y_arima, y_test);
R2_test = R_test(1, 2)^2;
disp(['拟合优度R2 = ', num2str(R2_test)])
c(:,t)=y_test;
 b(:,t)=y_arima;
   end
