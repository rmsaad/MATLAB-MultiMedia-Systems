function [block] = blockByBlock16(frame, row, col)
%BLOCKBYBLOCK16 Summary of this function goes here
%   returns a 16x16 block at row and col coordinates

% read in 8x8 blocks and perform operation
for x = 1:col
    for y = 1:row
        block = frame((row*16)-15:(row*16), (col*16)-15:(col*16));
    end
end

end

