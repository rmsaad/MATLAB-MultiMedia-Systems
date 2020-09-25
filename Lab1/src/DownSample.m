
function outFile = DownSample(inFile, N, pf)
%DOWNSAMPLE ~ Downsamples Dual channel Wav files  
% DownSamples by value of N
% use pf boolean to select whether to use pre-filter

% read input Wav file into y and Fs variables
[y,Fs] = audioread(inFile);

% Retain every Nth Sample
if pf == 0
    yDown(:, 1) = y(1:N:end, 1);
    yDown(:, 2) = y(1:N:end, 2);

% use the pre-filter decimate function to DownSample
elseif pf == 1
    yDown(:,1) = decimate(y(:, 1), N);
    yDown(:,2) = decimate(y(:, 2), N);
end 

% create DownSampled Wav File ...  
filename = 'ELE825_lab1_DownSample.wav';
audiowrite(filename ,yDown, floor(Fs/N));

% and set it to outFile
outFile = filename;

end

