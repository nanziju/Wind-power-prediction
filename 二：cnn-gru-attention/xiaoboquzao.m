%%初始化程序
clear;
t1=clock;
%数据导入
data=xlsread('shiyanyiorgin.xlsx');
YSJ=data;
%% 数据预处理，数据可能是存储在矩阵或者是EXCEL中的二维数据，衔接为一维的，如果数据是一维数据，此步骤也不会影响数据
 [c,l]=size(YSJ);
 GY=[];
 for j=1:l
   Y=[];
   for i=1:c
       Y=[Y,YSJ(i,j)];
   end
  [c1,l1]=size(Y);
  X=1:l1;
  %% 绘制噪声信号图像
   
    figure(j);
    subplot(2,1,1);
    plot(X,Y);
    xlabel('横坐标');
    ylabel('纵坐标');
    title('yuanshi');
    
    %% 小波阈值去噪
    lev=3;%分解层数
    xz=wden(Y,'minimaxi','h','sln',lev,'sym4');
    %minimaxi为极大极小阈值，可替换为sqtwolog（固定阈值）；heursure（启发式阈值）；rigrsure（无偏风险估计阈值）
    %h为硬阈值处理函数，可替换为s（软阈值处理函数）
    subplot(2,1,2);
    plot(X,xz);
    xlabel('横坐标');
    ylabel('纵坐标');
    title('小波');
    set(gcf,'Color',[1 1 1]);
    GY=[GY;xz];

    G=GY';
    %% 计算信噪比SNR
    Psig=sum(Y*Y')/l1;
    
    Pnoi3=sum((Y-xz)*(Y-xz)')/l1;
    
    SNR3=10*log10(Psig/Pnoi3);
    % 计算均方根误差RMSE
    
    RMSE3=sqrt(Pnoi3);
    % 输出结果
    disp(['-----这是第',num2str(j),'列数据结果————']);
   disp('-------------三种阈值设定方式的降噪处理结果---------------'); 
    disp(['去噪处理SNR=',num2str(SNR3),'，RMSE=',num2str(RMSE3)]);
     t2=clock;
     tim=etime(t2,t1);
     disp(['------------------运行耗时',num2str(tim),'秒-------------------'])
end