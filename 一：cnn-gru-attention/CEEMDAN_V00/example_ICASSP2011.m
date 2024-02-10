
% load ('ecg.mat');
StartingSamp=400;
StepSize=8000;
[ecg,fs,tm]=rdsamp('fantasia/f1o02',[2],(StartingSamp+StepSize),(StartingSamp+1));%nieyihang[5,36] 0.06 0.25 0.3;
[resp,fs,tm]=rdsamp('fantasia/f1o02',[1],(StartingSamp+StepSize),(StartingSamp+1));
% Nstd = 0.2;
% NR = 500;
% MaxIter = 5000;


[modes its]=ceemdan(ecg,0.2,500,5000);
t=1:length(ecg);

[a b]=size(modes);

figure(1);
subplot(a+1,1,1);
plot(t,ecg);% the ECG signal is in the first row of the subplot
ylabel('ECG')
set(gca,'xtick',[])
axis tight;

for i=2:a
    subplot(a+1,1,i);
    plot(t,modes(i-1,:));
    ylabel (['IMF ' num2str(i-1)]);
    set(gca,'xtick',[])
    xlim([1 length(ecg)])
end;

subplot(a+1,1,a+1)
plot(t,modes(a,:))
ylabel(['IMF ' num2str(a)])
xlim([1 length(ecg)])

figure(2);
boxplot(its);

resp1=imf(:,7)+imf(:,8)+imf(:,9)+imf(:,10);
figure(3);
subplot(211);plot(resp1);subplot(212);plot(resp);