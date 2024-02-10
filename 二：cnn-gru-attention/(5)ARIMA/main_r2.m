clc
clear all
close all
a1=xlsread('4predictions.xlsx');
a2=xlsread('sampleWindspeed4.xlsx');
y = sum(a1,2);
x = a2(775:965);

p = polyfit(x,y,1);
f = polyval(p,x);
[r2 rmse] = rsquare(y,f);
%figure
%plot(x,y,'b.');
%hold on; 
%plot(x,f,'r-');
%axis equal
%title(strcat(['R2 = ' num2str(r2) '; RMSE = ' num2str(rmse)]))
%str = ['y = ' num2str(p(1)) 'x + ' num2str(p(2))];
%gtext(str)
% text(mean(x),mean(y),str)
