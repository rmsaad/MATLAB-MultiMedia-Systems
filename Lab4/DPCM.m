function [entropy] = DPCM(current , prev, mode)
%DPCM Summary of this function goes here
%   Detailed explanation goes here

% init mode 1 array 
[h,w] = size(current);

switch mode 
    case 1
        temp = zeros(h,w,'uint8');
        temp(:, 1) =  current(:, 1);

        % perform DCPM mode 1
        for x = 2:w
            for y = 1:h
                temp(y, x) = (current(y, x)) - (prev(y, x-1));
            end
        end

        [~,~,entropy] = myEntropy(temp);
    
    case 2
        
        temp = zeros(h,w,'uint8');
        temp(1, :) =  current(1, :);

        % perform DCPM mode 2
        for x = 1:w
            for y = 2:h
                temp(y, x) = (current(y, x)) - (prev(y-1, x));
            end
        end

        [~,~,entropy] = myEntropy(temp);
        
    case 3
        temp = zeros(h,w,'uint8');
        temp(1, :) =  current(1, :);
        temp(:, 1) =  current(:, 1);
        
        % perform DCPM mode 2
        for x = 2:w
            for y = 2:h
                temp(y, x) = (current(y, x)) - (prev(y-1, x-1));
            end
        end

        [~,~,entropy] = myEntropy(temp);
    case 4
        temp = zeros(h,w,'uint8');
        temp(1, :) =  current(1, :);
        temp(:, 1) =  current(:, 1);
        
        % perform DCPM mode 2
        for x = 2:w
            for y = 2:h
                temp(y, x) = (current(y, x)) - ((prev(y, x-1)) + (prev(y-1, x)) - (prev(y-1, x-1)));
            end
        end

        [~,~,entropy] = myEntropy(temp);
end

end

