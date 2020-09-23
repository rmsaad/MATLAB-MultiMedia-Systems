function [euclid] = euclidean(refArr, inputArr)
%EUCLIDEAN Summary of this function goes here
%   Detailed explanation goes here

[~,w] = size(refArr);

temp = zeros(1,w);
for n = 1:w
    temp(n) = (refArr(n) - inputArr(n)) * (refArr(n) - inputArr(n));
end
euclid = sum(temp);
end

