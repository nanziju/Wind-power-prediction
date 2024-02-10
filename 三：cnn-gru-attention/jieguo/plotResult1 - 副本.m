clc;
clear;

linewidth = 1.5;
fontSize = 12;

orignal                = xlsread('shiyansan.xlsx');
CNN                = xlsread('CNN.xlsx');
GRU                = xlsread('GRU.xlsx');
 kelm           = xlsread('cnn-gru3.xlsx');
lstm      = xlsread('CNN-GRU-Attention.xlsx');
libsvm            =xlsread('iceemdan-cnn-gru-Attention.xlsx');
cnn      = xlsread('vmd-cnn-gru-attention.xlsx');
prophet     =xlsread('vmd-cnn-gru-attention-arima.xlsx');
neuralprophet      =xlsread('vmd-cnn-gru-attention-vmd-arima.xlsx');

figure;
subplot(2,4,[1 2 3]);
hold on;

pColor = [[240/255 23/255 22/255]; ...
          [165/255 94/255 234/255]; ...
          [124/255 187/255 0/255]; ...
          [255/255 142/255 23/255]; ...
          [209/255 234/255 58/255]; ...
          [119/255 45/255 134/255]; ...
          [17/255 133/255 245/255]; ...
          [81/255 225/255 116/255]; ...
          [140/255 140/255 100/255]];
      
plot(orignal,'color',pColor(1,:),'linewidth', linewidth);
plot(CNN,'color',pColor(2,:),'linewidth', linewidth);
plot(GRU,'color',pColor(3,:),'linewidth', linewidth);
plot(kelm,'color',pColor(4,:),'linewidth', linewidth);
plot(lstm,'color',pColor(5,:),'linewidth', linewidth);
plot(libsvm,'color',pColor(6,:),'linewidth', linewidth);
plot(cnn,'color',pColor(7,:),'linewidth', linewidth);
plot(prophet,'color',pColor(8,:),'linewidth', linewidth);
plot(neuralprophet,'color',pColor(9,:),'linewidth', linewidth);

xlabel('Time (15min)');
ylabel('Wind wind power(MV)');
axis tight;
set(gca,'FontName','Times New Roman','FontSize',fontSize,'Box','on','TickDir','in','linewidth', linewidth);
legend('Actrol wind power','CNN','GRU','CNN-GRU','CNN-GRU-Attention','ICEEMDAN-CNN-GRU-Attention','VMD-CNN-GRU-Attention','VMD-CNN-GRU-Attention-Arima','VMD-CNN-GRU-Attention-VMD-Arima','FontName','Times New Roman','FontSize',10,'FontAngle','italic','Box','off');



subplot(244)
hold on;
plot(orignal,orignal,'color',pColor(1,:),'linewidth', linewidth);
axis tight;
scatter(orignal, CNN, 'MarkerEdgeColor', pColor(2,:),'linewidth', linewidth);
scatter(orignal, GRU, 'MarkerEdgeColor', pColor(3,:),'linewidth', linewidth);
scatter(orignal, kelm, 'MarkerEdgeColor', pColor(4,:),'linewidth', linewidth);
scatter(orignal, lstm, 'MarkerEdgeColor', pColor(5,:),'linewidth', linewidth);
scatter(orignal, libsvm, 'MarkerEdgeColor', pColor(6,:),'linewidth', linewidth);
scatter(orignal, cnn, 'MarkerEdgeColor', pColor(7,:),'linewidth', linewidth);
scatter(orignal, prophet, 'MarkerEdgeColor', pColor(8,:),'linewidth', linewidth);
scatter(orignal, neuralprophet, 'MarkerEdgeColor', pColor(9,:),'linewidth', linewidth);
xlabel('Actual values');
ylabel('Predicted values');
min = 0;
max = 17.5;
xlim([min max]);
ylim([min max]);
set(gca,'FontName','Times New Roman','FontSize',fontSize,'Box','on','TickDir','in','linewidth', linewidth);
legend('Actrol wind power','CNN','GRU','CNN-GRU','CNN-GRU-Attention','ICEEMDAN-CNN-GRU-Attention','VMD-CNN-GRU-Attention','VMD-CNN-GRU-Attention-Arima','VMD-CNN-GRU-Attention-VMD-Arima','FontName','Times New Roman','FontSize',10,'FontAngle','italic','Box','off');

mse_prophet1 =  mean((orignal-CNN).^2);
mse_prophet_arima1 =  mean((orignal-GRU).^2);
mse_prophet =  mean((orignal-kelm).^2);
mse_prophet_arima =  mean((orignal-lstm).^2);
mse_neuralprophet =  mean((orignal-libsvm).^2);
mse_neuralprophet_arima =  mean((orignal-cnn).^2);
mse_mlp =  mean((orignal-prophet).^2);
mse_mlp_arima =  mean((orignal-neuralprophet).^2);


mae_prophet1 = sum(abs(orignal-CNN))/length(orignal);
mae_prophet_arima1 = sum(abs(orignal-GRU))/length(orignal);
mae_prophet = sum(abs(orignal-kelm))/length(orignal);
mae_prophet_arima = sum(abs(orignal-lstm))/length(orignal);
mae_neuralprophet = sum(abs(orignal-libsvm))/length(orignal);
mae_neuralprophet_arima = sum(abs(orignal-cnn))/length(orignal);
mae_mlp = sum(abs(orignal-prophet))/length(orignal);
mae_mlp_arima = sum(abs(orignal-neuralprophet))/length(orignal);

rmse_prophet1 = sqrt(sum(abs(orignal-CNN).^2)/length(orignal));
rmse_prophet_arima1 = sqrt(sum(abs(orignal-GRU).^2)/length(orignal));
rmse_prophet = sqrt(sum(abs(orignal-kelm).^2)/length(orignal));
rmse_prophet_arima = sqrt(sum(abs(orignal-lstm).^2)/length(orignal));
rmse_neuralprophet = sqrt(sum(abs(orignal-libsvm).^2)/length(orignal));
rmse_neuralprophet_arima = sqrt(sum(abs(orignal-cnn).^2)/length(orignal));
rmse_mlp = sqrt(sum(abs(orignal-prophet).^2)/length(orignal));
rmse_mlp_arima = sqrt(sum(abs(orignal-neuralprophet).^2)/length(orignal));

nan = find(orignal==0);
for i = 1:length(nan)
    orignal(nan(i)-i+1) = []; 
    CNN(nan(i)-i+1) = []; 
    GRU(nan(i)-i+1) = []; 
    kelm(nan(i)-i+1) = []; 
    lstm(nan(i)-i+1) = []; 
    libsvm(nan(i)-i+1) = []; 
    cnn(nan(i)-i+1) = []; 
    prophet(nan(i)-i+1) = [];      
    neuralprophet(nan(i)-i+1) = [];     
end
mape_prophet1 = sum(abs((orignal-CNN)./orignal))/length(orignal);
mape_prophet_arima1 = sum(abs((orignal-GRU)./orignal))/length(orignal);
mape_prophet = sum(abs((orignal-kelm)./orignal))/length(orignal);
mape_prophet_arima = sum(abs((orignal-lstm)./orignal))/length(orignal);
mape_neuralprophet = sum(abs((orignal-libsvm)./orignal))/length(orignal);
mape_neuralprophet_arima = sum(abs((orignal-cnn)./orignal))/length(orignal);
mape_mlp = sum(abs((orignal-prophet)./orignal))/length(orignal); 
mape_mlp_arima = sum(abs((orignal-neuralprophet)./orignal))/length(orignal);


R_prophet1 = corrcoef(orignal,CNN); R2_prophet1 = R_prophet1(1, 2)^2;
R_prophet_arima1 = corrcoef(orignal,GRU); R2_prophet_arima1 = R_prophet_arima1(1, 2)^2;
R_prophet = corrcoef(orignal,kelm); R2_prophet = R_prophet(1, 2)^2;
R_prophet_arima = corrcoef(orignal,lstm); R2_prophet_arima = R_prophet_arima(1, 2)^2;
R_neuralprophet = corrcoef(orignal,libsvm);     R2_neuralprophet = R_neuralprophet(1, 2)^2;
R_neuralprophet_arima = corrcoef(orignal,cnn);       R2_neuralprophet_arima = R_neuralprophet_arima(1, 2)^2;
R_mlp = corrcoef(orignal,prophet);               R2_mlp = R_mlp(1, 2)^2;
R_mlp_arima = corrcoef(orignal,neuralprophet);     R2_mlp_arima = R_mlp_arima(1, 2)^2;

% R_prophet = corrcoef(orignal-kelm);R2_prophet = R_prophet(1, 2)^2;
% R2_prophet = sum(abs((orignal-kelm)./orignal))/length(orignal);
% R2_prophet_arima = sum(abs((orignal-lstm)./orignal))/length(orignal);
% R2_neuralprophet = sum(abs((orignal-libsvm)./orignal))/length(orignal);
% R2_neuralprophet_arima = sum(abs((orignal-cnn)./orignal))/length(orignal);
% R2_mlp = sum(abs((orignal-prophet)./orignal))/length(orignal); 
% R2_mlp_arima = sum(abs((orignal-neuralprophet)./orignal))/length(orignal);


bColor = [[17/255 133/255 200/255]; ...
          [81/255 225/255 116/255]; ...
          [119/255 45/255 134/255]; ...
          [245/255 172/255 23/255]; ...
          [239/255 234/255 58/255]; ...
           [165/255 94/255 234/255]; ...
          [124/255 187/255 0/255]; ...
          [220/255 23/255 22/255]];


subplot(245);
% hold on;
% b_mae_prophet = bar(1,mae_prophet);
% set(b_mae_prophet, 'FaceColor', bColor(1,:));
% b_mae_prophet_arima = bar(2,mae_prophet_arima);
% set(b_mae_prophet_arima, 'FaceColor', bColor(2,:));
% b_mae_neuralprophet = bar(3,mae_neuralprophet);
% set(b_mae_neuralprophet, 'FaceColor', bColor(3,:));
% b_mae_neuralprophet_arima = bar(4,mae_neuralprophet_arima);
% set(b_mae_neuralprophet_arima, 'FaceColor', bColor(4,:));
% b_mae_mlp = bar(5,mae_mlp);
% set(b_mae_mlp, 'FaceColor', bColor(5,:));
% b_mae_mlp_arima = bar(6,mae_mlp_arima);
% set(b_mae_mlp_arima, 'FaceColor', bColor(6,:));
% xlabel('Date 3','FontSize',fontSize);
% ylabel('MAE','FontSize',fontSize);
% set(gca,'XTickLabel',[]);
% set(gca,'FontName','Times New Roman','FontSize',fontSize,'Box','on','TickDir','in','linewidth', linewidth);
hold on;
b_mse_prophet1 = bar(1,mse_prophet1);
set(b_mse_prophet1, 'FaceColor', bColor(1,:));
b_mse_prophet_arima1 = bar(2,mse_prophet_arima1);
set(b_mse_prophet_arima1, 'FaceColor', bColor(2,:));
b_mse_prophet = bar(3,mse_prophet);
set(b_mse_prophet, 'FaceColor', bColor(3,:));
b_mse_prophet_arima = bar(4,mse_prophet_arima);
set(b_mse_prophet_arima, 'FaceColor', bColor(4,:));
b_mse_neuralprophet = bar(5,mse_neuralprophet);
set(b_mse_neuralprophet, 'FaceColor', bColor(5,:));
b_mse_neuralprophet_arima = bar(6,mse_neuralprophet_arima);
set(b_mse_neuralprophet_arima, 'FaceColor', bColor(6,:));
b_mse_mlp = bar(7,mse_mlp);
set(b_mse_mlp, 'FaceColor', bColor(7,:));
b_mse_mlp_arima = bar(8,mse_mlp_arima);
set(b_mse_mlp_arima, 'FaceColor', bColor(8,:));
xlabel('Date 3','FontSize',fontSize);
ylabel('MSE','FontSize',fontSize);
set(gca,'XTickLabel',[]);
set(gca,'FontName','Times New Roman','FontSize',fontSize,'Box','on','TickDir','in','linewidth', linewidth);

legend('CNN','GRU','CNN-GRU','CNN-GRU-Attention','ICEEMDAN-CNN-GRU-Attention','VMD-CNN-GRU-Attention','VMD-CNN-GRU-Attention-Arima','VMD-CNN-GRU-Attention-VMD-Arima','FontName','Times New Roman','FontSize',10,'FontAngle','italic','Box','off');


subplot(246);
hold on;
b_rmse_prophet1 = bar(1,rmse_prophet1);
set(b_rmse_prophet1, 'FaceColor', bColor(1,:));
b_rmse_prophet_arima1 = bar(2,rmse_prophet_arima1);
set(b_rmse_prophet_arima1, 'FaceColor', bColor(2,:));
b_rmse_prophet = bar(3,rmse_prophet);
set(b_rmse_prophet, 'FaceColor', bColor(3,:));
b_rmse_prophet_arima = bar(4,rmse_prophet_arima);
set(b_rmse_prophet_arima, 'FaceColor', bColor(4,:));
b_rmse_neuralprophet = bar(5,rmse_neuralprophet);
set(b_rmse_neuralprophet, 'FaceColor', bColor(5,:));
b_rmse_neuralprophet_arima = bar(6,rmse_neuralprophet_arima);
set(b_rmse_neuralprophet_arima, 'FaceColor', bColor(6,:));
b_rmse_mlp = bar(7,rmse_mlp);
set(b_rmse_mlp, 'FaceColor', bColor(7,:));
b_rmse_mlp_arima = bar(8,rmse_mlp_arima);
set(b_rmse_mlp_arima, 'FaceColor', bColor(8,:));
xlabel('Date 3','FontSize',fontSize);
ylabel('RMSE','FontSize',fontSize);
% ylim([0 1]);
set(gca,'XTickLabel',[]);
set(gca,'FontName','Times New Roman','FontSize',fontSize,'Box','on','TickDir','in','linewidth', linewidth);
% legend('CNN','GRU','CNN-GRU','CNN-GRU-Attention','ICEEMDAN-CNN-GRU-Attention','VMD-CNN-GRU-Attention','VMD-CNN-GRU-Attention-Arima','VMD-CNN-GRU-Attention-VMD-Arima','FontName','Times New Roman','FontSize',10,'FontAngle','italic','Box','off');

subplot(247);
hold on;
b_mape_prophet1 = bar(1,mape_prophet1);
set(b_mape_prophet1, 'FaceColor', bColor(1,:));
b_mape_prophet_arima1 = bar(2,mape_prophet_arima1);
set(b_mape_prophet_arima1, 'FaceColor', bColor(2,:));
b_mape_prophet = bar(3,mape_prophet);
set(b_mape_prophet, 'FaceColor', bColor(3,:));
b_mape_prophet_arima = bar(4,mape_prophet_arima);
set(b_mape_prophet_arima, 'FaceColor', bColor(4,:));
b_mape_neuralprophet = bar(5,mape_neuralprophet);
set(b_mape_neuralprophet, 'FaceColor', bColor(5,:));
b_mape_neuralprophet_arima = bar(6,mape_neuralprophet_arima);
set(b_mape_neuralprophet_arima, 'FaceColor', bColor(6,:));
b_mape_mlp = bar(7,mape_mlp);
set(b_mape_mlp, 'FaceColor', bColor(7,:));
b_mape_mlp_arima = bar(8,mape_mlp_arima);
set(b_mape_mlp_arima, 'FaceColor', bColor(8,:));
xlabel('Date 3','FontSize',fontSize);
ylabel('MAPE (%)','FontSize',fontSize);
% ylim([0 0.09]);
set(gca,'XTickLabel',[]);
yTick = get(gca, 'YTick')*100;
% ylim([0 0.07]);
set(gca,'YTickLabel',yTick);
set(gca,'FontName','Times New Roman','FontSize',fontSize,'Box','on','TickDir','in','linewidth', linewidth);
% legend('CNN','GRU','CNN-GRU','CNN-GRU-Attention','ICEEMDAN-CNN-GRU-Attention','VMD-CNN-GRU-Attention','VMD-CNN-GRU-Attention-Arima','VMD-CNN-GRU-Attention-VMD-Arima','FontName','Times New Roman','FontSize',10,'FontAngle','italic','Box','off');

subplot(248);
hold on;
b_R2_prophet1 = bar(1,R2_prophet1);
set(b_R2_prophet1, 'FaceColor', bColor(1,:));
b_R2_prophet_arima1 = bar(2,R2_prophet_arima1);
set(b_R2_prophet_arima1, 'FaceColor', bColor(2,:));
b_R2_prophet = bar(3,R2_prophet);
set(b_R2_prophet, 'FaceColor', bColor(3,:));
b_R2_prophet_arima = bar(4,R2_prophet_arima);
set(b_R2_prophet_arima, 'FaceColor', bColor(4,:));
b_R2_neuralprophet = bar(5,R2_neuralprophet);
set(b_R2_neuralprophet, 'FaceColor', bColor(5,:));
b_R2_neuralprophet_arima = bar(6,R2_neuralprophet_arima);
set(b_R2_neuralprophet_arima, 'FaceColor', bColor(6,:));
b_R2_mlp = bar(7,R2_mlp);
set(b_R2_mlp, 'FaceColor', bColor(7,:));
b_R2_mlp_arima = bar(8,R2_mlp_arima);
set(b_R2_mlp_arima, 'FaceColor', bColor(8,:));
xlabel('Date 3','FontSize',fontSize);
ylabel('R2','FontSize',fontSize);
 ylim([0.5 1.01]);
% set(gca,'XTickLabel',[]);
% yTick = get(gca, 'YTick');
% ylim([0 0.07]);
% set(gca,'YTickLabel',yTick);
set(gca,'XTickLabel',[]);
set(gca,'FontName','Times New Roman','FontSize',fontSize,'Box','on','TickDir','in','linewidth', linewidth);
% legend('CNN','GRU','CNN-GRU','CNN-GRU-Attention','ICEEMDAN-CNN-GRU-Attention','VMD-CNN-GRU-Attention','VMD-CNN-GRU-Attention-Arima','VMD-CNN-GRU-Attention-VMD-Arima','FontName','Times New Roman','FontSize',10,'FontAngle','italic','Box','off');

