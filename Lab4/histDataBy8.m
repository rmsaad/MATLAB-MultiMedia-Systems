function [freqData] = histDataBy8(inputImage)
%HISTDATA Summary of this function goes here
%   returns a 1D vector of color histogram frequency data

%split the Image into 8 Blocks
% _______________________
%|     |     |     |     |
%|_____|_____|_____|_____|
%|     |     |     |     |
%|_____|_____|_____|_____|

% declare empty vector
freqData = [];

% 30 bins for first channel
amt = 30;

for n = 1:3
    
    % split image horizontally
    image = inputImage(:, :, n);
    bot = image(1 : floor(end/2), :);
    top = image(floor(end/2+1) : end, : );
    
    % divide into 8 subimages
    [n1, ~] = histcounts(bot(:, 1 : floor(end/4)),                amt);
    [n2, ~] = histcounts(bot(:, floor(end/4+1) : floor(end/2)),   amt);
    [n3, ~] = histcounts(bot(:, floor(end/2+1) : floor(3*end/4)), amt);
    [n4, ~] = histcounts(bot(:, floor(3*end/4+1) : end),          amt);
    [n5, ~] = histcounts(top(:, 1 : floor(end/4)),                amt);
    [n6, ~] = histcounts(top(:, floor(end/4+1) : floor(end/2)),   amt);
    [n7, ~] = histcounts(top(:, floor(end/2+1) : floor(3*end/4)), amt);
    [n8, ~] = histcounts(top(:, floor(3*end/4+1) : end),          amt);
    
    % 15 bins for last 2 channels
    if n == 1
      amt = 15;  
    end
    
    % append to output vector
    freqData = [freqData n1 n2 n3 n4 n5 n6 n7 n8];
end

freqData = freqData/(sum(freqData)); 
end

