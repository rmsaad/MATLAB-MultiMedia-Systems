function outFile = MuLawQuant(inFile, N, Mu)
%MULAWQUANT Summary of this function goes here
%   Detailed explanation goes here

% read input Wav file into y and Fs variables
[y,Fs] = audioread(inFile);

% variables need for uniform Quantization 
xMax = max(abs(y(:)));
M = N^2;
stepSize = (2*xMax)/M;

% Transform signal using Mu-law
yIn(:, 1) = (xMax).*((log(1+(Mu.*((abs(y(:, 1)))./xMax))))./(log(1+Mu))) .*sign(y(:, 1));
yIn(:, 2) = (xMax).*((log(1+(Mu.*((abs(y(:, 2)))./xMax))))./(log(1+Mu))) .*sign(y(:, 2));

% Quantize the transformed vaule using uniform qunatizer
uniform(:, 1) = (floor(yIn(:, 1)./stepSize) + 0.5) * stepSize;
uniform(:, 2) = (floor(yIn(:, 2)./stepSize) + 0.5) * stepSize;

% Transform the quantized value back using inverse Mu-law
yOut(:, 1) = (xMax./Mu).* (exp(((log(1+Mu)/xMax).*abs(uniform(:, 1)))) - 1) .*sign(uniform(:, 1));
yOut(:, 2) = (xMax./Mu).* (exp(((log(1+Mu)/xMax).*abs(uniform(:, 2)))) - 1) .*sign(uniform(:, 2));

% create Quantized Wav File ...  
filename = 'ELE825_lab1_MuLawSample.wav';
audiowrite(filename ,yOut, Fs);

% and set it to outFile
outFile = filename;
end

