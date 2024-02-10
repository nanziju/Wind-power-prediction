clc;
clear;

linewidth = 1.5;
fontSize = 12;

orignal                = xlsread('shiyansan.xlsx');
% CNN                = xlsread('CNN.xlsx');
% GRU                = xlsread('GRU.xlsx');
%  kelm           = xlsread('cnn-gru3.xlsx');
kelm1       = xlsread('EMD-cnn-gru-attention.xlsx');
kelm2       = xlsread('eemd-cnn-gru-attention.xlsx');
kelm       = xlsread('iceemdan-cnn-gru-Attention.xlsx');
lstm           =xlsread('vmd-cnn-gru-attention.xlsx');
libsvm     = xlsread('iceemdan-cnn-gru-attention-ARIMA.xlsx');
cnn      =xlsread('vmd-cnn-gru-attention-ARIMA.xlsx');
prophet      =xlsread('vmd-cnn-gru-attention-vmd-ARIMA.xlsx');
figure;
subplot(2,6,[1 2 3 4]);
hold on;
pColor = [[240/255 23/255 22/255]; ...
          [255/255 142/255 23/255]; ...
          [209/255 234/255 58/255]; ...
          [119/255 45/255 134/255]; ...
          [220/255 23/255 22/255]; ...
           [81/255 225/255 116/255]; ...
           [17/255 133/255 245/255]; ...
          [140/255 140/255 100/255]];
      
plot(orignal,'color',pColor(1,:),'linewidth', linewidth);
plot(kelm1,'color',pColor(2,:),'linewidth', linewidth);
plot(kelm2,'color',pColor(3,:),'linewidth', linewidth);
plot(kelm,'color',pColor(4,:),'linewidth', linewidth);
plot(lstm,'color',pColor(5,:),'linewidth', linewidth);
plot(libsvm,'color',pColor(6,:),'linewidth', linewidth);
plot(cnn,'color',pColor(7,:),'linewidth', linewidth);
plot(prophet,'color',pColor(8,:),'linewidth', linewidth);


xlabel('Time (15min)', 'FontName', 'Times New Roman', 'FontWeight', 'normal', 'FontAngle', 'italic');
ylabel('Wind wind power(MW)', 'FontName', 'Times New Roman', 'FontWeight', 'normal', 'FontAngle', 'italic');
axis tight;
set(gca,'FontName','Times New Roman','FontSize',fontSize,'Box','on','TickDir','in','linewidth', linewidth);
legend('Actual wind power', ...
'EMD-CNN-GRU-Attention','EEMD-CNN-GRU-Attention','ICEEMDAN-CNN-GRU-Attention','VMD-CNN-GRU-Attention','ICEEMDAN-CNN-GRU-Attention-ARIMA','VMD-CNN-GRU-Attention-ARIMA','VMD-CNN-GRU-Attention-VMD-ARIMA','FontName','Times New Roman','FontSize',10,'FontAngle','italic','Box','off','Location','northwest');


subplot(2,6,[5 6])
hold on;
plot(orignal,orignal,'color',pColor(1,:),'linewidth', linewidth);
axis tight;
scatter(orignal, kelm1, 'MarkerEdgeColor', pColor(2,:),'linewidth', linewidth);
scatter(orignal, kelm2, 'MarkerEdgeColor', pColor(3,:),'linewidth', linewidth);
scatter(orignal, kelm, 'MarkerEdgeColor', pColor(4,:),'linewidth', linewidth);
scatter(orignal, lstm, 'MarkerEdgeColor', pColor(5,:),'linewidth', linewidth);
scatter(orignal, libsvm, 'MarkerEdgeColor', pColor(6,:),'linewidth', linewidth);
scatter(orignal, cnn, 'MarkerEdgeColor', pColor(7,:),'linewidth', linewidth);
scatter(orignal, prophet, 'MarkerEdgeColor', pColor(8,:),'linewidth', linewidth);

xlabel('Actual values', 'FontName', 'Times New Roman', 'FontWeight', 'normal', 'FontAngle', 'italic');
ylabel('Predicted values', 'FontName', 'Times New Roman', 'FontWeight', 'normal', 'FontAngle', 'italic');
min = 0;
max = 17.5;
xlim([min max]);
ylim([min max]);
set(gca,'FontName','Times New Roman','FontSize',fontSize,'Box','on','TickDir','in','linewidth', linewidth);
legend('Actual wind power','EMD-CNN-GRU-Attention','EEMD-CNN-GRU-Attention','ICEEMDAN-CNN-GRU-Attention','VMD-CNN-GRU-Attention','ICEEMDAN-CNN-GRU-Attention-ARIMA','VMD-CNN-GRU-Attention-ARIMA','VMD-CNN-GRU-Attention-VMD-ARIMA','FontName','Times New Roman','FontSize',10,'FontAngle','italic','Box','off','Location','northwest');

mse_prophet =  mean((orignal-kelm).^2);
mse_prophet_arima =  mean((orignal-lstm).^2);
mse_neuralprophet =  mean((orignal-libsvm).^2);
mse_neuralprophet_arima =  mean((orignal-cnn).^2);
mse_mlp =  mean((orignal-prophet).^2);
disp(['mse= ', num2str(mse_prophet)])
disp(['mse = ', num2str(mse_prophet_arima)])
disp(['mse = ', num2str(mse_neuralprophet)])
disp(['mse = ', num2str(mse_neuralprophet_arima)])
disp(['mse = ', num2str(mse_mlp)])
mae_prophet1 = sum(abs(orignal-kelm1))/length(orignal);
mae_prophet2 = sum(abs(orignal-kelm2))/length(orignal);
mae_prophet = sum(abs(orignal-kelm))/length(orignal);
mae_prophet_arima = sum(abs(orignal-lstm))/length(orignal);
mae_neuralprophet = sum(abs(orignal-libsvm))/length(orignal);
mae_neuralprophet_arima = sum(abs(orignal-cnn))/length(orignal);
mae_mlp = sum(abs(orignal-prophet))/length(orignal);
disp(['mae = ', num2str(mae_prophet1)])
disp(['mae = ', num2str(mae_prophet2)])
disp(['mae = ', num2str(mae_prophet)])
disp(['mae = ', num2str(mae_prophet_arima)])
disp(['mae = ', num2str(mae_neuralprophet)])
disp(['mae = ', num2str(mae_neuralprophet_arima)])
disp(['mae = ', num2str(mae_mlp)])

rmse_prophet1 = sqrt(sum(abs(orignal-kelm1).^2)/length(orignal));
rmse_prophet2 = sqrt(sum(abs(orignal-kelm2).^2)/length(orignal));
rmse_prophet = sqrt(sum(abs(orignal-kelm).^2)/length(orignal));
rmse_prophet_arima = sqrt(sum(abs(orignal-lstm).^2)/length(orignal));
rmse_neuralprophet = sqrt(sum(abs(orignal-libsvm).^2)/length(orignal));
rmse_neuralprophet_arima = sqrt(sum(abs(orignal-cnn).^2)/length(orignal));
rmse_mlp = sqrt(sum(abs(orignal-prophet).^2)/length(orignal));

numerator1 = sqrt(sum((orignal - kelm1).^2));
denominator1 =sqrt(sum(orignal.^2)) + sqrt(sum(kelm1.^2));
R2_prophet11 =numerator1 / denominator1; 
numerator1 = sqrt(sum((orignal - kelm2).^2));
denominator1 =sqrt(sum(orignal.^2)) + sqrt(sum(kelm2.^2));
R2_prophet22 =numerator1 / denominator1; 

numerator1 = sqrt(sum((orignal - kelm).^2));
denominator1 =sqrt(sum(orignal.^2)) + sqrt(sum(kelm.^2));
R2_prophet =numerator1 / denominator1; 
numerator2=sqrt(sum((orignal - lstm).^2));
denominator2=sqrt(sum(orignal.^2)) + sqrt(sum(lstm.^2));
R2_prophet_arima =numerator2 / denominator2; 
numerator3=sqrt(sum((orignal - libsvm).^2));
denominator3 = sqrt(sum(orignal.^2)) + sqrt(sum(libsvm.^2))
R2_neuralprophet = numerator3 / denominator3 ;
numerator4=sqrt(sum((orignal - cnn).^2));
denominator4= sqrt(sum(orignal.^2)) + sqrt(sum(cnn.^2));
R2_neuralprophet_arima =numerator4 / denominator4; 
numerator5= sqrt(sum((orignal - prophet).^2)) ;
denominator5=sqrt(sum(orignal.^2)) + sqrt(sum(prophet.^2));   
R2_mlp =numerator5 / denominator5; 




n = length(orignal);
R2_prophet11= sqrt(sum((orignal - kelm1).^2) / n) / (sqrt(sum((orignal- mean(orignal)).^2) / n) + sqrt(sum((kelm1 - mean(kelm1)).^2) / n));
R2_prophet22= sqrt(sum((orignal - kelm2).^2) / n) / (sqrt(sum((orignal- mean(orignal)).^2) / n) + sqrt(sum((kelm2 - mean(kelm2)).^2) / n));
R2_prophet1= sqrt(sum((orignal - kelm).^2) / n) / (sqrt(sum((orignal- mean(orignal)).^2) / n) + sqrt(sum((kelm - mean(kelm)).^2) / n));
% R2_prophet1= sqrt(sum((orignal - kelm ).^2) / n) / (sqrt(sum((orignal - meanObserved1).^2) / n) + sqrt(sum((kelm - meanPredicted1).^2) / n));
R2_prophet_arima1= sqrt(sum((orignal - lstm).^2) / n) / (sqrt(sum((orignal- mean(orignal)).^2) / n) + sqrt(sum((lstm - mean(lstm)).^2) / n));
R2_neuralprophet1= sqrt(sum((orignal - libsvm).^2) / n) / (sqrt(sum((orignal- mean(orignal)).^2) / n) + sqrt(sum((libsvm - mean(libsvm)).^2) / n));
R2_neuralprophet_arima1= sqrt(sum((orignal - cnn).^2) / n) / (sqrt(sum((orignal- mean(orignal)).^2) / n) + sqrt(sum((cnn - mean(cnn)).^2) / n));
R2_mlp1= sqrt(sum((orignal - prophet).^2) / n) / (sqrt(sum((orignal- mean(orignal)).^2) / n) + sqrt(sum((prophet - mean(prophet)).^2) / n));



nan = find(orignal==0);
for i = 1:length(nan)
    orignal(nan(i)-i+1) = []; 
    kelm1(nan(i)-i+1) = []; 
    kelm2(nan(i)-i+1) = []; 
    kelm(nan(i)-i+1) = []; 
    lstm(nan(i)-i+1) = []; 
    libsvm(nan(i)-i+1) = []; 
    cnn(nan(i)-i+1) = []; 
    prophet(nan(i)-i+1) = [];      

end

mape_prophet1 = sum(abs((orignal-kelm1)./orignal))/length(orignal);
mape_prophet2 = sum(abs((orignal-kelm2)./orignal))/length(orignal);
mape_prophet = sum(abs((orignal-kelm)./orignal))/length(orignal);
mape_prophet_arima = sum(abs((orignal-lstm)./orignal))/length(orignal);
mape_neuralprophet = sum(abs((orignal-libsvm)./orignal))/length(orignal);
mape_neuralprophet_arima = sum(abs((orignal-cnn)./orignal))/length(orignal);
mape_mlp = sum(abs((orignal-prophet)./orignal))/length(orignal); 
disp(['mape = ', num2str(mape_prophet1)])
disp(['mape = ', num2str(mape_prophet2)])
disp(['mape = ', num2str(mape_prophet)])
disp(['mape = ', num2str(mape_prophet_arima)])
disp(['mape = ', num2str(mape_neuralprophet)])
disp(['mape = ', num2str(mape_neuralprophet_arima)])
disp(['mape = ', num2str(mape_mlp)])


% 分位数
tau = 0.5; % 例如，使用中位数

% 初始化弹球损失
pinball_loss = 0;

% 计算弹球损失
n = length(orignal);

for i = 1:n
    if orignal(i) > kelm1(i)
        pinball_loss = pinball_loss + tau * (orignal(i) - kelm1(i));
    else
        pinball_loss = pinball_loss + (1 - tau) * (kelm1(i) - orignal(i));
    end
end
% 计算平均弹球损失
p1 = pinball_loss / n;
% 输出结果
fprintf('平均弹球损失: %f\n', p1);


% 分位数
tau = 0.5; % 例如，使用中位数

% 初始化弹球损失
pinball_loss = 0;

% 计算弹球损失
n = length(orignal);
for i = 1:n
    if orignal(i) > kelm2(i)
        pinball_loss = pinball_loss + tau * (orignal(i) - kelm2(i));
    else
        pinball_loss = pinball_loss + (1 - tau) * (kelm2(i) - orignal(i));
    end
end
% 计算平均弹球损失
p2= pinball_loss / n;
% 输出结果
fprintf('平均弹球损失: %f\n', p2);

% 分位数
tau = 0.5; % 例如，使用中位数

% 初始化弹球损失
pinball_loss = 0;

% 计算弹球损失
n = length(orignal);
for i = 1:n
    if orignal(i) > kelm(i)
        pinball_loss = pinball_loss + tau * (orignal(i) - kelm(i));
    else
        pinball_loss = pinball_loss + (1 - tau) * (kelm(i) - orignal(i));
    end
end
% 计算平均弹球损失
p3 = pinball_loss / n;
% 输出结果
fprintf('平均弹球损失: %f\n', p3);


% 分位数
tau = 0.5; % 例如，使用中位数

% 初始化弹球损失
pinball_loss = 0;

% 计算弹球损失
n = length(orignal);
for i = 1:n
    if orignal(i) > lstm(i)
        pinball_loss = pinball_loss + tau * (orignal(i) - lstm(i));
    else
        pinball_loss = pinball_loss + (1 - tau) * (lstm(i) - orignal(i));
    end
end
% 计算平均弹球损失
p4= pinball_loss / n;
% 输出结果
fprintf('平均弹球损失: %f\n', p4);

% 分位数
tau = 0.5; % 例如，使用中位数

% 初始化弹球损失
pinball_loss = 0;

% 计算弹球损失
n = length(orignal);
for i = 1:n
    if orignal(i) > libsvm(i)
        pinball_loss = pinball_loss + tau * (orignal(i) - libsvm(i));
    else
        pinball_loss = pinball_loss + (1 - tau) * (libsvm(i) - orignal(i));
    end
end
% 计算平均弹球损失
p5 = pinball_loss / n;
% 输出结果
fprintf('平均弹球损失: %f\n', p5);



% 分位数
tau = 0.5; % 例如，使用中位数

% 初始化弹球损失
pinball_loss = 0;

% 计算弹球损失
n = length(orignal);
for i = 1:n
    if orignal(i) > cnn(i)
        pinball_loss = pinball_loss + tau * (orignal(i) - cnn(i));
    else
        pinball_loss = pinball_loss + (1 - tau) * (cnn(i) - orignal(i));
    end
end
% 计算平均弹球损失
p6= pinball_loss / n;
% 输出结果
fprintf('平均弹球损失: %f\n', p6);


% 分位数
tau = 0.5; % 例如，使用中位数

% 初始化弹球损失
pinball_loss = 0;

% 计算弹球损失
n = length(orignal);
for i = 1:n
    if orignal(i) > prophet(i)
        pinball_loss = pinball_loss + tau * (orignal(i) - prophet(i));
    else
        pinball_loss = pinball_loss + (1 - tau) * (prophet(i) - orignal(i));
    end
end
% 计算平均弹球损失
p7 = pinball_loss / n;
% 输出结果
fprintf('平均弹球损失: %f\n', p7);




disp(['rmse = ', num2str(rmse_prophet1)])
disp(['rmse = ', num2str(rmse_prophet2)])
disp(['rmse = ', num2str(rmse_prophet)])
disp(['rmse = ', num2str(rmse_prophet_arima)])
disp(['rmse = ', num2str(rmse_neuralprophet)])
disp(['rmse = ', num2str(rmse_neuralprophet_arima)])
disp(['rmse = ', num2str(rmse_mlp)])

disp(['Theil1s U统计量 = ', num2str(R2_prophet11)])
disp(['Theil2s U统计量 = ', num2str(R2_prophet22)])
disp(['Theil’s U统计量 = ', num2str(R2_prophet)])
disp(['Theil’s U统计量 = ', num2str(R2_prophet_arima)])
disp(['Theil’s U统计量 = ', num2str(R2_neuralprophet)])
disp(['Theil’s U统计量 = ', num2str(R2_neuralprophet_arima)])
disp(['Theil’s U统计量 = ', num2str(R2_mlp)])

disp([' TIC  = ', num2str(R2_prophet11)])
disp([' TIC  = ', num2str(R2_prophet22)])
disp([' TIC  = ', num2str(R2_prophet1)])
disp([' TIC  = ', num2str(R2_prophet_arima1)])
disp([' TIC  = ', num2str(R2_neuralprophet1)])
disp([' TIC = ', num2str(R2_neuralprophet_arima1)])
disp([' TIC = ', num2str(R2_mlp1)])



bColor = [[17/255 133/255 200/255]; ...
          [81/255 225/255 116/255]; ...
          [119/255 45/255 134/255]; ...
          [245/255 172/255 23/255]; ...
          [239/255 234/255 58/255]; ...
           [65/255 130/255 90/255]; ...
          [220/255 23/255 22/255]];

subplot(267);
hold on;
b_mse_prophet = bar(1,mse_prophet);
set(b_mse_prophet, 'FaceColor', bColor(1,:));
b_mse_prophet_arima = bar(2,mse_prophet_arima);
set(b_mse_prophet_arima, 'FaceColor', bColor(2,:));
b_mse_neuralprophet = bar(3,mse_neuralprophet);
set(b_mse_neuralprophet, 'FaceColor', bColor(3,:));

b_mse_prophet_arima = bar(4,mse_prophet_arima);
set(b_mse_prophet_arima, 'FaceColor', bColor(4,:));
b_mse_neuralprophet = bar(5,mse_neuralprophet);
set(b_mse_neuralprophet, 'FaceColor', bColor(5,:));

b_mse_neuralprophet_arima = bar(6,mse_neuralprophet_arima);
set(b_mse_neuralprophet_arima, 'FaceColor', bColor(6,:));
b_mse_mlp = bar(7,mse_mlp);
set(b_mse_mlp, 'FaceColor', bColor(7,:));

xlabel('Date 3','FontSize',fontSize, 'FontName', 'Times New Roman', 'FontWeight', 'normal', 'FontAngle', 'italic');
ylabel('MSE','FontSize',fontSize, 'FontName', 'Times New Roman', 'FontWeight', 'normal', 'FontAngle', 'italic');
set(gca,'XTickLabel',[]);
set(gca,'FontName','Times New Roman','FontSize',fontSize,'Box','on','TickDir','in','linewidth', linewidth);

legend('EMD-CNN-GRU-Attention','EEMD-CNN-GRU-Attention','ICEEMDAN-CNN-GRU-Attention','VMD-CNN-GRU-Attention','ICEEMDAN-CNN-GRU-Attention-ARIMA','VMD-CNN-GRU-Attention-ARIMA','VMD-CNN-GRU-Attention-VMD-ARIMA','FontName','Times New Roman','FontSize',10,'FontAngle','italic','Box','off','Location','northwest');


subplot(268);
hold on;
b_rmse_prophet = bar(1,rmse_prophet1);
set(b_rmse_prophet, 'FaceColor', bColor(1,:));
b_rmse_prophet_arima = bar(2,rmse_prophet2 );
set(b_rmse_prophet_arima, 'FaceColor', bColor(2,:));
b_rmse_neuralprophet = bar(3,rmse_prophet);
set(b_rmse_neuralprophet, 'FaceColor', bColor(3,:));

b_rmse_prophet_arima = bar(4,rmse_prophet_arima);
set(b_rmse_prophet_arima, 'FaceColor', bColor(4,:));
b_rmse_neuralprophet = bar(5,rmse_neuralprophet);
set(b_rmse_neuralprophet, 'FaceColor', bColor(5,:));

b_rmse_neuralprophet_arima = bar(6,rmse_neuralprophet_arima);
set(b_rmse_neuralprophet_arima, 'FaceColor', bColor(6,:));
b_rmse_mlp = bar(7,rmse_mlp);
set(b_rmse_mlp, 'FaceColor', bColor(7,:));

xlabel('Date 3','FontSize',fontSize, 'FontName', 'Times New Roman', 'FontWeight', 'normal', 'FontAngle', 'italic');
ylabel('RMSE','FontSize',fontSize, 'FontName', 'Times New Roman', 'FontWeight', 'normal', 'FontAngle', 'italic');
% ylim([0 1]);
set(gca,'XTickLabel',[]);
set(gca,'FontName','Times New Roman','FontSize',fontSize,'Box','on','TickDir','in','linewidth', linewidth);
% legend('Elm','Lstm','Cnn','Prophet','Libsvm','Neuralprophet','FontName','Times New Roman','FontSize',10,'FontAngle','italic','Box','off');

subplot(2,6,9);
hold on;
b_mape_prophet = bar(1,mape_prophet1);
set(b_mape_prophet, 'FaceColor', bColor(1,:));
b_mape_prophet_arima = bar(2,mape_prophet2);
set(b_mape_prophet_arima, 'FaceColor', bColor(2,:));
b_mape_neuralprophet1 = bar(3,mape_prophet);
set(b_mape_neuralprophet1, 'FaceColor', bColor(3,:));
b_mape_prophet_arima1 = bar(4,mape_prophet_arima);
set(b_mape_prophet_arima1, 'FaceColor', bColor(4,:));
b_mape_neuralprophet = bar(5,mape_neuralprophet);
set(b_mape_neuralprophet, 'FaceColor', bColor(5,:));
b_mape_neuralprophet_arima = bar(6,mape_neuralprophet_arima);
set(b_mape_neuralprophet_arima, 'FaceColor', bColor(6,:));
b_mape_mlp = bar(7,mape_mlp);
set(b_mape_mlp, 'FaceColor', bColor(7,:));

xlabel('Date 3','FontSize',fontSize, 'FontName', 'Times New Roman', 'FontWeight', 'normal', 'FontAngle', 'italic');
ylabel('MAPE','FontSize',fontSize, 'FontName', 'Times New Roman', 'FontWeight', 'normal', 'FontAngle', 'italic');
% ylim([0 0.09]);
% set(gca,'XTickLabel',[]);
% yTick = get(gca, 'YTick')*100;
% % ylim([0 0.07]);
set(gca,'XTickLabel',[]);
set(gca,'FontName','Times New Roman','FontSize',fontSize,'Box','on','TickDir','in','linewidth', linewidth);
% legend('Elm','Lstm','Cnn','Prophet','Libsvm','Neuralprophet','FontName','Times New Roman','FontSize',10,'FontAngle','italic','Box','off');

subplot(2,6,10);
hold on;
b_R2_prophet = bar(1,R2_prophet11);
set(b_R2_prophet, 'FaceColor', bColor(1,:));
b_R2_prophet_arima = bar(2,R2_prophet22 );
set(b_R2_prophet_arima, 'FaceColor', bColor(2,:));
b_R2_neuralprophet = bar(3,R2_prophet);
set(b_R2_neuralprophet, 'FaceColor', bColor(3,:));

b_R2_prophet_arima = bar(4,R2_prophet_arima);
set(b_R2_prophet_arima, 'FaceColor', bColor(4,:));
b_R2_neuralprophet = bar(5,R2_neuralprophet);
set(b_R2_neuralprophet, 'FaceColor', bColor(5,:));

b_R2_neuralprophet_arima = bar(6,R2_neuralprophet_arima);
set(b_R2_neuralprophet_arima, 'FaceColor', bColor(6,:));
b_R2_mlp = bar(7,R2_mlp);
set(b_R2_mlp, 'FaceColor', bColor(7,:));

xlabel('Date 3','FontSize',fontSize, 'FontName', 'Times New Roman', 'FontWeight', 'normal', 'FontAngle', 'italic');
ylabel('Theil’s U','FontSize',fontSize, 'FontName', 'Times New Roman', 'FontWeight', 'normal', 'FontAngle', 'italic');
 set(gca,'XTickLabel',[]);
set(gca,'FontName','Times New Roman','FontSize',fontSize,'Box','on','TickDir','in','linewidth', linewidth);
% legend('WTD-NP-Libsvm','WTD-NP-VMD-Libsvm','WTD-NP-VMD-ICEEMDAN-Libsvm','WTD-NP-ICEEMDAN-Libsvm','WTD-NP-ICEEMDAN-ICEEMDAN-Libsvm','WTD-NP-ICEEMDAN-VMD-Libsvm','FontName','Times New Roman','FontSize',10,'FontAngle','italic','Box','off');



subplot(2,6,11);
hold on;
b_R2_prophet3 = bar(1,R2_prophet11);
set(b_R2_prophet3, 'FaceColor', bColor(1,:));
b_R2_prophet_arima3 = bar(2,R2_prophet22);
set(b_R2_prophet_arima3, 'FaceColor', bColor(2,:));
b_R2_neuralprophet3 = bar(3,R2_prophet1);
set(b_R2_neuralprophet3, 'FaceColor', bColor(3,:));

b_R2_prophet_arima3 = bar(4,R2_prophet_arima1);
set(b_R2_prophet_arima3, 'FaceColor', bColor(4,:));
b_R2_neuralprophet3 = bar(5,R2_neuralprophet1);
set(b_R2_neuralprophet3, 'FaceColor', bColor(5,:));

b_R2_neuralprophet_arima3 = bar(6,R2_neuralprophet_arima1);
set(b_R2_neuralprophet_arima3, 'FaceColor', bColor(6,:));
b_R2_mlp3 = bar(7,R2_mlp1);
set(b_R2_mlp3, 'FaceColor', bColor(7,:));

xlabel('Date 3','FontSize',fontSize, 'FontName', 'Times New Roman', 'FontWeight', 'normal', 'FontAngle', 'italic');
ylabel('TIC','FontSize',fontSize, 'FontName', 'Times New Roman', 'FontWeight', 'normal', 'FontAngle', 'italic');
 set(gca,'XTickLabel',[]);
set(gca,'FontName','Times New Roman','FontSize',fontSize,'Box','on','TickDir','in','linewidth', linewidth);
% legend('WTD-NP-Libsvm','WTD-NP-VMD-Libsvm','WTD-NP-VMD-ICEEMDAN-Libsvm','WTD-NP-ICEEMDAN-Libsvm','WTD-NP-ICEEMDAN-ICEEMDAN-Libsvm','WTD-NP-ICEEMDAN-VMD-Libsvm','FontName','Times New Roman','FontSize',10,'FontAngle','italic','Box','off');


subplot(2,6,12);
hold on;
b_R2_prophet2 = bar(1,p1);
set(b_R2_prophet2, 'FaceColor', bColor(1,:));
b_R2_prophet_arima2 = bar(2,p2);
set(b_R2_prophet_arima2, 'FaceColor', bColor(2,:));
b_R2_neuralprophet2 = bar(3,p3);
set(b_R2_neuralprophet2, 'FaceColor', bColor(3,:));

b_R2_prophet_arima2 = bar(4,p4);
set(b_R2_prophet_arima2, 'FaceColor', bColor(4,:));
b_R2_neuralprophet2 = bar(5,p5);
set(b_R2_neuralprophet2, 'FaceColor', bColor(5,:));

b_R2_neuralprophet_arima2 = bar(6,p6);
set(b_R2_neuralprophet_arima2, 'FaceColor', bColor(6,:));
b_R2_mlp2 = bar(7,p7);
set(b_R2_mlp2, 'FaceColor', bColor(7,:));

xlabel('Date 3','FontSize',fontSize, 'FontName', 'Times New Roman', 'FontWeight', 'normal', 'FontAngle', 'italic');
ylabel('SPL','FontSize',fontSize, 'FontName', 'Times New Roman', 'FontWeight', 'normal', 'FontAngle', 'italic');
 set(gca,'XTickLabel',[]);
set(gca,'FontName','Times New Roman','FontSize',fontSize,'Box','on','TickDir','in','linewidth', linewidth);
% legend('WTD-NP-Libsvm','WTD-NP-VMD-Libsvm','WTD-NP-VMD-ICEEMDAN-Libsvm','WTD-NP-ICEEMDAN-Libsvm','WTD-NP-ICEEMDAN-ICEEMDAN-Libsvm','WTD-NP-ICEEMDAN-VMD-Libsvm','FontName','Times New Roman','FontSize',10,'FontAngle','italic','Box','off');
