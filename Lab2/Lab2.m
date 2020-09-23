%  ELE 725 Lab 1 Report
%  *Authors:*  Rami Saad (500637869)
%% Part I: Calculating Entropy of a Source
%%  Steps 1 & 2 

% test sequence
test_seq = 'HUFFMAN IS THE BEST COMPRESSION ALGORITHM';

% find entropy and probability vector of test sequence
[symbol_test,prob_test,ent_test] = myEntropy(test_seq);

% display results
fprintf("Printing Probability Vector\n")
fprintf('%0.4g ', prob_test);
fprintf("\nPrinting Entropy\n")
fprintf('%g ', ent_test);

bar(prob_test);
set(gca, 'XTickLabel',{'_', 'A', 'B', 'C', 'E', 'F', 'G', 'H', 'I', 'L', 'M', 'N', 'O', 'P', 'R', 'S', 'T', 'U'}, 'XTick',1:18)
xlabel('Symbols');
ylabel('Probability');
title('Test Sequence Histogram');

%%  Step 3 

% loading image into matlab Workspace
img_in_1  = imread('input.bmp');

% find entropy and probability vector of grayscale image
[symbol_gray,prob_gray,ent_gray] = myEntropy(img_in_1);

% display results
fprintf("Printing Probability Vector\n")
fprintf('%0.3g ', prob_gray);
fprintf("\nPrinting Entropy\n")
fprintf('%g ', ent_gray);

bar(symbol_gray,prob_gray);
xlabel('Symbols');
ylabel('Probability');
title('Gray Scale Histogram');

%%  Step 3 cont.

% loading image into matlab Workspace
RGB = imread('peppers.png');

% convert from RGB to YCbCr
YCBCR = rgb2ycbcr(RGB);

% find entropy and probability vector of YCbCr color space image
[symbol_Y,prob_Y,ent_Y   ] = myEntropy(YCBCR(:,:,1));
[symbol_Cb,prob_Cb,ent_Cb] = myEntropy(YCBCR(:,:,2));
[symbol_Cr,prob_Cr,ent_Cr] = myEntropy(YCBCR(:,:,3));

% display results
fprintf("Printing Entropy\n")
fprintf('%g %g %g', ent_Y, ent_Cb, ent_Cr);

%% Histogram Y
bar(symbol_Y,prob_Y);
xlabel('Symbols');
ylabel('Probability');
title('Y Channel Histogram');

%% Histogram Cb
bar(symbol_Cb,prob_Cb);
xlabel('Symbols');
ylabel('Probability');
title('Cb Channel Histogram');

%% Histogram Cr
bar(symbol_Cr,prob_Cr);
xlabel('Symbols');
ylabel('Probability');
title('Cr Channel Histogram');

%%  Step 4

% calculate compression ratio
comp_test = 8.0/ent_test;
comp_gray = 8.0/ent_gray;
compYCbCr = 24.0/ (ent_Y + ent_Cb+ ent_Cr);

%% Part 2: Huffman Encoder

% test sequence result

[code_test ,tree_test] = createTree(symbol_test,prob_test);

encoded_data = huffEncode(symbol_test, code_test, test_seq, 'char');

[h,w] = size(test_seq);
decoded_data_test = huffDecode(symbol_test, code_test, encoded_data, h, w, "char");

%% Image result

[code ,tree] = createTree(symbol_gray,prob_gray);

encoded_data = huffEncode(symbol_gray, code, img_in_1, 'image');

[h,w] = size(img_in_1);
decoded_data = huffDecode(symbol_gray, code, encoded_data, h, w, 'image');

imshow(decoded_data)
