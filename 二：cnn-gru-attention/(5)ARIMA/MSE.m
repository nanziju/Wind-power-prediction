%Find the rmse of vec1 and vec2
function [ res ] = MSE( vec1, vec2 )
n=length(vec1);
v = abs(vec1 - vec2);
v = (v.^2);
%m = mean(v);
res = (v(:,1)/n);
res=mean(res);
end