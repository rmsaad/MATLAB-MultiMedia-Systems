function [decoded] = huffDecode(sym, code, encoded,h,w, type)
%MYENTROPY Summary of this function goes here
%   Detailed explanation goes here

cursor = 1;
curData = 1;
end_pointer = 0;


temp2 = zeros(h,w);

while (cursor <= length(encoded))
   
   temp = encoded(cursor:cursor+end_pointer);  
   
   for curSym = 1:length(code)
        if length(temp) == length(code{1,curSym}) && isequal(temp, code{1,curSym})
            temp2(curData) = sym(curSym);
            cursor = cursor+end_pointer+1;
            end_pointer = 0;
            curData = curData + 1;
        end
   end
    end_pointer = end_pointer + 1;
    
end

% char array input
if type == "char"
    
    % convert to ascii
    decoded = char(temp2);

end
if type == "image"
    
    % convert to ascii
    decoded = uint8(temp2);

end

end