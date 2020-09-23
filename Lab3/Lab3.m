%  ELE 725 Lab 3 Report
%  *Authors:*  Rami Saad (500637869)
%% Part I: Intra-Frame Coding (DCT)
%%  Step 1 Create dct function

% loading image into matlab Workspace
img_in_1  = imread('cameraman.tif');

dct_im1 = dct_function(img_in_1);

%%  Step 2 4x4, 8x8, 32x32

% loading image into matlab Workspace
img_in_1  = imread('cameraman.tif');

% array sizes
Nkeep4  =  3;
Nkeep8  =  7;
Nkeep32 = 31;
pos = 150;

% dct transform
dct_im2 = dct_function(img_in_1(pos:pos+Nkeep4, pos:pos+Nkeep4));
dct_im3 = dct_function(img_in_1(pos:pos+Nkeep8, pos:pos+Nkeep8));
dct_im4 = dct_function(img_in_1(pos:pos+Nkeep32, pos:pos+Nkeep32));

%% DCT results  4x4
%imshow(img_in_1(pos:pos+Nkeep4, pos:pos+Nkeep4));
imshow(imcomplement(log(abs(dct_im2))));

% remove borders from image
set(gca, 'units', 'pixels');
x = get(gca, 'position');
set(gcf, 'units', 'pixels');
y = get(gcf, 'position');
set(gcf, 'position', [y(1) y(2) x(3) x(4)]);
set(gca,'units', 'normalized', 'position', [0 0 1 1]);

%% DCT results  8x8
%imshow(img_in_1(pos:pos+Nkeep8, pos:pos+Nkeep8));
imshow(imcomplement(log(abs(dct_im3))));

% remove borders from image
set(gca, 'units', 'pixels');
x = get(gca, 'position');
set(gcf, 'units', 'pixels');
y = get(gcf, 'position');
set(gcf, 'position', [y(1) y(2) x(3) x(4)]);
set(gca,'units', 'normalized', 'position', [0 0 1 1]);
%% DCT results 32x32
%imshow(img_in_1(pos:pos+Nkeep32, pos:pos+Nkeep32));
imshow(imcomplement(log(abs(dct_im4))));

% remove borders from image
set(gca, 'units', 'pixels');
x = get(gca, 'position');
set(gcf, 'units', 'pixels');
y = get(gcf, 'position');
set(gcf, 'position', [y(1) y(2) x(3) x(4)]);
set(gca,'units', 'normalized', 'position', [0 0 1 1]);
%% Step 3 IDCT

restored_im2 = uint8(idct2(dct_im2));
restored_im3 = uint8(idct2(dct_im3));
restored_im4 = uint8(idct2(dct_im4));

%% IDCT results  4x4
imshow(restored_im2);

%% IDCT results  8x8
imshow(restored_im3);

%% IDCT results 32x32
imshow(restored_im4);

%% Step 4

% Low coefficients from low frequency are responsible for more
% characteristics of the image, thats why in jpeg compression the higher
% freqeuncies wiil be removed to compress the image even further because it
% is reponsible for less of the image quality

%% Step 5 DCT in 8x8 blocks 

[dct_8x8_blocks,restored_8x8_blocks] = DCT_Lossless(img_in_1);

imshow(imcomplement(log(abs(dct_8x8_blocks))));
%imshow(restored_8x8_blocks);

% remove borders from image
set(gca, 'units', 'pixels');
x = get(gca, 'position');
set(gcf, 'units', 'pixels');
y = get(gcf, 'position');
set(gcf, 'position', [y(1) y(2) x(3) x(4)]);
set(gca,'units', 'normalized', 'position', [0 0 1 1]);
%% Step 6 Lossy DCT in 8x8 blocks

[dct_8x8_blocks_loss,restored_8x8_blocks_loss] = DCT_Lossy(img_in_1);

%imshow(imcomplement(log(abs(dct_8x8_blocks_loss))));
imshow(restored_8x8_blocks_loss);

% remove borders from image
set(gca, 'units', 'pixels');
x = get(gca, 'position');
set(gcf, 'units', 'pixels');
y = get(gcf, 'position');
set(gcf, 'position', [y(1) y(2) x(3) x(4)]);
set(gca,'units', 'normalized', 'position', [0 0 1 1]);

% mean square and SNR
mse = immse(restored_8x8_blocks_loss, img_in_1); 
[peakSNR,signal_noise_ratio] = psnr(restored_8x8_blocks_loss,img_in_1);
%% Part II: Inter-Frame Coding (DPCM)
%% Step 1 Frame difference between frame 2 and 1

% read video with video reader
v = VideoReader('vipboard.mp4');

% get first 11 frames of the video
frames = uint8(zeros(240, 360, 11));
for i = 1:11
    frames(:,:,i) = rgb2gray(readFrame(v));
end

% frame difference between frames
difference = uint8(zeros(240, 360, 10));
for i = 1:10
    difference(:,:,i) = frames(:,:,i+1) - frames(:,:,i);
end

% first frame difference
imshow(imcomplement(difference(:,:,10)));

%% Step 2 Frame Difference Entropy plot

entropy = zeros(1,10);
for i = 1:10
    [sym,prob,entropy(i)] = myEntropy(difference(:,:,i));
end

x = 1:10;

stem(x, entropy);
title("Entropy of Frame Differences (11 Frames)"); 
xlabel("Frame Difference"); ylabel("Entropy (bpp)");
xlim([0 11]); grid on;


%% Step find compression ratio

uncompressed = 240 * 320 * 8 * 11;

% first uncompressed frame 
compressed   = 240 * 320 * 8 * 1;
          
% other 10 frame differences
for i = 1:10
    compressed = compressed + 240 * 320 * entropy(i) * 1;
end

%compression ratio
comp_ratio = uncompressed / compressed;

%% Step 4
%% DPCM mode 1

% init mode 1 array 
mode1 = zeros(240, 320, 11);
mode1(:, 1, :) =  frames(:, 1, :);

% init output array
mode1_diff = uint8(zeros(240, 320, 10));

% perform DCPM mode 1
for z = 1:10
    for y = 2:320
        for x = 1:240
            mode1(x, y, z) = double(frames(x, y, z+1)) - double(frames(x, y-1, z));
        end
    end
end
 
mode1_entropy = zeros(1,10);
for i = 1:10
    [sym,prob,mode1_entropy(i)] = myEntropy(mode1(:,:,i));
end
%% DPCM mode 2

% init mode 2 array 
mode2 = uint8(zeros(240, 320, 11));
mode2(1, :, :) =  frames(1, :, :);

% perform DCPM mode 2
for z = 1:10
    for y = 1:320
        for x = 2:240
            mode1(x, y, z) = double(frames(x, y, z+1)) - double(frames(x-1, y, z));
        end
    end
end

mode2_entropy = zeros(1,10);
for i = 1:10
    [sym,prob,mode2_entropy(i)] = myEntropy(mode2(:,:,i));
end

%% DPCM mode 3

% init mode 3 array 
mode3 = uint8(zeros(240, 320, 11));
mode3(:, 1, :) =  frames(:, 1, :);
mode3(1, :, :) =  frames(1, :, :);

% perform DCPM mode 3
for z = 1:10
    for y = 2:320
        for x = 2:240
            mode3(x, y, z) = double(frames(x, y, z+1)) - double(frames(x-1, y-1, z));
        end
    end
end

mode3_entropy = zeros(1,10);
for i = 1:10
    [sym,prob,mode3_entropy(i)] = myEntropy(mode3(:,:,i));
end

%% DPCM mode 4

% init mode 4 array 
mode4 = uint8(zeros(240, 320, 11));
mode4(:, 1, :) =  frames(:, 1, :);
mode4(1, :, :) =  frames(1, :, :);

% perform DCPM mode 4
for z = 1:10
    for y = 2:320
        for x = 2:240
            mode4(x, y, z) = double(frames(x, y, z+1)) - double(frames(x, y-1, z)) + double(frames(x-1, y, z)) - double(frames(x-1, y-1, z));
        end
    end
end

mode4_entropy = zeros(1,10);
for i = 1:10
    [sym,prob,mode4_entropy(i)] = myEntropy(mode4(:,:,i));
end



