function [freqData] = histData(inputImage)
%HISTDATA Summary of this function goes here
%   returns a 1D vector of color histogram frequency data

[freq1, ~] = histcounts(inputImage(:, :, 1), 30);
[freq2, ~] = histcounts(inputImage(:, :, 2), 15);
[freq3, ~] = histcounts(inputImage(:, :, 3), 15);

freqData = [freq1 freq2 freq3];
freqData = freqData/(sum(freqData)); 
end

