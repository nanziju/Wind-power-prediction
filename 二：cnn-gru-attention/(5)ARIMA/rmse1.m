function [ res ] = rmse1( vec1, vec2 )
n=length(vec1);
v = abs(vec1 - vec2);
v = v.^2;
%m = mean(v);
res = sqrt(v(:,1)/n);
res=mean(res);
end