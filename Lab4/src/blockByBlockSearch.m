function [block] = blockByBlockSearch(frame, row, col, k)
%BLOCKBYBLOCK16 Summary of this function goes here
%   returns a (16*2k)x(16*2k) block at row and col coordinates

%find the size of the frame
[h,w] = size(frame);

% read in 8x8 blocks and perform operation
for x = 1:col
    for y = 1:row
        
        % define the boundaries
        rowStart = (row*16) - 15 - k;
        rowEnd   = (row*16) + k;
        colStart = (col*16) - 15 - k;
        colEnd   = (col*16) + k;
        
        % make sure that the vector exists
        if rowStart < 1
            rowStart = 1;
        end
        
        % ""
        if colStart < 1
            colStart = 1;
        end
        
        % ""
        if rowEnd > h
            rowEnd = h;
        end
        
        % ""
        if colEnd > w
            colEnd = w;
        end
        
        
        block = frame(rowStart:rowEnd, colStart:colEnd);
    end
end

end