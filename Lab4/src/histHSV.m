function [] = histHSV(inputImage)
%HISTHSV Summary of this function goes here
%   Detailed explanation goes here

hImage = inputImage(:, :, 1);
sImage = inputImage(:, :, 2);
vImage = inputImage(:, :, 3);

figure;
subplot(2,2,1);
hHist = histogram(hImage);
grid on;
title('Hue Histogram');
subplot(2,2,2);
sHist = histogram(sImage);
grid on;
title('Saturation Histogram');
subplot(2,2,3);
vHist = histogram(vImage);
grid on;
title('Value Histogram');
subplot(2,2,4);
conv = hsv2rgb(inputImage);
imshow(conv);
end

