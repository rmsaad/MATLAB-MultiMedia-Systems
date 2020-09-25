function [DCT,img_data_out] = DCT_Lossless(img_data_in)
%DCT_LOSSLESS Summary of this function goes here
%   Detailed explanation goes here

% read the size of the image
[h,w] = size(img_data_in); 

% create out image data array
DCT          = zeros(h,w);
img_data_out = zeros(h,w);


% read in 8x8 blocks and perform operation
for x = 1:(w/8)
    for y = 1:(h/8)
        DCT((x*8)-7:(x*8), (y*8)-7:(y*8)) = dct_function(img_data_in((x*8)-7:(x*8), (y*8)-7:(y*8)));
    end
end

% perform idct on 8x8 blocks
for x = 1:(w/8)
    for y = 1:(h/8)
        img_data_out((x*8)-7:(x*8), (y*8)-7:(y*8)) = uint8(idct2(DCT((x*8)-7:(x*8), (y*8)-7:(y*8))));
    end
end

% convert to integer
img_data_out = uint8(img_data_out);

end

