function [cityBlock] = cityBlock(refArr, inputArr)
%CITYBLOCK Summary of this function goes here
%   Detailed explanation goes here

[~,w] = size(refArr);

temp = zeros(1,w);
for n = 1:w
    temp(n) = abs(refArr(n) - inputArr(n));
end
cityBlock = sum(temp);
end

