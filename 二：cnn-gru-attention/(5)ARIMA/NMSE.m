%% NMSE Calculation
function [ err ] = NMSE( vec1, vec2 ) 
%Function to compute the normalized mean square error.
v = abs(vec1 - vec2);
v = v.^2;
s1 = sum(v); 
s2 = sum(abs(vec1 - mean(vec2)));
s2=s2.^2;
err = s1(:,1)/s2(:,1);
end 