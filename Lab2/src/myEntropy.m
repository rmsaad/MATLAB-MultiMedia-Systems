function [symbol,prob_vec,entropy] = myEntropy(input)
%MYENTROPY Summary of this function goes here
%   Detailed explanation goes here


% char array input
if class(input) == "char"
    
    % convert to ascii
    input = uint8(input);

end

% find unique symbols
sym = unique(input);

% get sizes
[n,m] = size(input);
[p,o] = size(sym);

% init array
prob_not_weighted = zeros(1,o*p);

% begin creating probability vector
for in = 1:(m*n)
    for lut = 1:(o*p)

        if input(in) == sym(lut)
            prob_not_weighted(lut) = prob_not_weighted(lut) + 1;  
        end

    end
end

% symbol output
if p ~= 1
    sym = transpose(sym);
end
symbol = sym;

% finish creating probabilty vector output
prob_vec = prob_not_weighted./(m*n);

% calculate entropy output
entropy = -sum(prob_vec .* log2(prob_vec));


end

