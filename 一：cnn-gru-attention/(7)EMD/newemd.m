clear;
clc;
%load strFileName;
%varargin = state(:,1)
varargin=xlsread('xifangshiyou.xlsx');
varargin=varargin(:,4);
varargin=varargin(1:221);
 %load y2
% varargin = y2(1:10000);
 figure;
plot(varargin,'b*-','linewidth',2);
title('西方石油','FontName','宋体')
legend({'原始序列'},'FontName','宋体')
xlabel('采样个数','FontName','宋体')
ylabel('收盘价','FontName','宋体')

%varargin=xlsread('yakou.xlsx');
%varargin=varargin(:,32);
%varargin=varargin(1:2000);


%varargin=xlsread('Arou');
%varargin=varargin(:,3);
%varargin=varargin(1:2000);

imf = emdcode(varargin);
emd_visu(varargin,imf) 
IMF=sprintf('E:\\EMD\\%d.mat');
save('IMF.mat','imf');
load IMF
data=imf(1,:);
%[pe ,hist, c]=pec(imf,9,9);