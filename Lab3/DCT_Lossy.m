function [DCT,img_data_out] = DCT_Lossy(img_data_in)
%DCT_LOSSLESS Summary of this function goes here
%   Detailed explanation goes here

quant =  [16, 11, 10, 16,  24,  40,  51,  61;
		  12, 12, 14, 19,  26,  58,  60,  55;
		  14, 13, 16, 24,  40,  57,  69,  56;
		  14, 17, 22, 29,  51,  87,  80,  62;
		  18, 22, 37, 56,  68, 109, 103,  77;
		  24, 35, 55, 64,  81, 104, 113,  92;
		  49, 64, 78, 87, 103, 121, 120, 101;
		  72, 92, 95, 98, 112, 100, 103,  99];

% read the size of the image
[h,w] = size(img_data_in); 

% create out image data array
quant_data   = zeros(h,w);
un_quant_data= zeros(h,w); 
DCT          = zeros(h,w);
img_data_out = zeros(h,w);


% read in 8x8 blocks and perform operation + QUNATIZATION
for x = 1:(w/8)
    for y = 1:(h/8)
        %dct
        DCT(x*8-7:x*8, y*8-7:y*8) = dct_function(img_data_in(x*8-7:x*8, y*8-7:y*8));
        
        %quantize
        quant_data(x*8-7:x*8, y*8-7:y*8) = round(DCT(x*8-7:x*8, y*8-7:y*8) ./ quant);
    end
end

% REVERSE QUANTIZATION + perform idct on 8x8 blocks
for x = 1:(w/8)
    for y = 1:(h/8)
        
        % reverse quantize
        un_quant_data(x*8-7:x*8, y*8-7:y*8) = quant_data(x*8-7:x*8, y*8-7:y*8) .* quant;
        
        % idct
        img_data_out(x*8-7:x*8, y*8-7:y*8) =(idct2(un_quant_data(x*8-7:x*8, y*8-7:y*8)));
    end
end


% convert to integer
img_data_out = uint8(img_data_out);

end