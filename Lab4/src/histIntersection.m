function [intersect] = histIntersection(refArr, inputArr)
%HISTINTERSECTION Summary of this function goes here
%   Detailed explanation goes here

[~,w] = size(refArr);

temp = zeros(1,w);
for n = 1:w
    if refArr(n) < inputArr(n)
        temp(n) = refArr(n);
    else
        temp(n) = inputArr(n);
    end
end
intersect = sum(temp)/w;

end

