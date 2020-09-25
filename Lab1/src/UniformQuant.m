function outFile = UniformQuant(inFile, N)
%UNIFORMQUANT Summary of this function goes here
%   Detailed explanation goes here

% read input Wav file into y and Fs variables
[y,Fs] = audioread(inFile);

% variables need for uniform Quantization
vMax = max(abs(y(:)));
M = N^2;
stepSize = (2*vMax)/M;

% Quantize the transformed vaule using uniform qunatizer
yUniform(:, 1) = (floor(y(:, 1)/stepSize) + 0.5) * stepSize;
yUniform(:, 2) = (floor(y(:, 2)/stepSize) + 0.5) * stepSize;

% create Quantized Wav File ...  
filename = 'ELE825_lab1_UniformSample.wav';
audiowrite(filename ,yUniform, Fs);

% and set it to outFile
outFile = filename;

end

