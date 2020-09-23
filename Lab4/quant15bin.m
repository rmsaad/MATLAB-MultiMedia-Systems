function [outputArr] = quant15bin(inputArr)
%QUANT30BIN Summary of this function goes here
%   Detailed explanation goes here

% Look up table to compare against
LUT = 0:(1/14):1;

% get the size of the input arr
[h,w] = size(inputArr);

% init the output arr
outputArr = zeros(h,w);

%% perform the quantization
for x = 1:w
    for y = 1:h
    [c, index] = min(abs(LUT-inputArr(y,x)));
    outputArr(y,x) = LUT(index);
    end
end


end

