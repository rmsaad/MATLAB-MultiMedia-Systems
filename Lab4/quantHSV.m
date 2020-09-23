function [outHSV] = quantHSV(imageRGB)
%HISTHSV Summary of this function goes here
%   Detailed explanation goes here

% convert to HSV color space
imageHSV = rgb2hsv(imageRGB);

% separate channels
hImage = imageHSV(:, :, 1);
sImage = imageHSV(:, :, 2);
vImage = imageHSV(:, :, 3);

% quantize each channel to their specifications
hImage = quant30bin(hImage);
sImage = quant15bin(sImage);
vImage = quant15bin(vImage);

% store as 1 three dimensional variable
outHSV(:, :, 1) = hImage;
outHSV(:, :, 2) = sImage;
outHSV(:, :, 3) = vImage;

end

