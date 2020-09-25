function [encoded] = huffEncode(sym, code, data, type)
%MYENTROPY Summary of this function goes here
%   Detailed explanation goes here

% char array input
if type == "char"
    
    % convert to ascii
    data = uint8(data);

end

temp = num2cell(zeros(1,length(data)));
[a,b] = size(data);

for curData = 1:(a*b)
    for curSym = 1:length(sym)
        if data(curData) == sym(curSym)
            temp(curData) = code(curSym);
        end
    end
end

encoded = cell2mat(temp);
end