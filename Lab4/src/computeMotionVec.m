function [dy,dx,bestMatch] = computeMotionVec(framePrev, frameCurr, p, q, k)
%COMPUTEMOTIONVEC Summary of this function goes here
%   Detailed explanation goes here

% grab the current frame 16x16
currMatchBlock = blockByBlock16(frameCurr, p, q);

% grab the full search area from the Previous Frame
PrevSearchBlock = blockByBlockSearch(framePrev, p, q, k); 

% do the MAD search
MADFinal = [ 0, 0, inf];

[h1,w1] = size(currMatchBlock);
[h2,w2] = size(PrevSearchBlock);

for row = 1:(h2-h1+1)
    for col = 1:(w2-w1+1)
        MAD = sum(sum(abs(currMatchBlock - PrevSearchBlock(row:row+15, col:col+15))));
        MAD = MAD/(16*16);
        if MAD < MADFinal(3)
            MADFinal = [row, col, MAD];
            bestMatch = PrevSearchBlock(row:row+15, col:col+15);
        end
    end
end

dy = MADFinal(1) - 7 - 1;
dx = MADFinal(2) - 7 - 1;

% edge cases  
if h2 < 30 && p == 1
    dy = MADFinal(1) - 1;
end

% ""
if w2 < 30 && q == 1
    dx = MADFinal(2) - 1;
end


end

