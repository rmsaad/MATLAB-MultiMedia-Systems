%  ELE 725 Lab 4 Report
%  *Authors:*  Rami Saad (500637869)
%% Part I: Motion Vector Computation
%% Step 1 Open Video File

% read video with video reader
vid = VideoReader('vipboard.mp4');

% Step 2 Extract first two Frames, gray scale

% get first 2 frames of the video
tempframes = uint8(zeros(240, 360, 2));
frames = uint8(zeros(240, 352, 2));

for i = 1:120
    a = readFrame(vid);
    if i == 20
        tempframes(:,:,1) = rgb2gray(readFrame(vid));
    elseif i == 21
        tempframes(:,:,2) = rgb2gray(readFrame(vid));
    end
end

frames(:,:,1) = tempframes(:,1:end-8,1);
frames(:,:,2) = tempframes(:,1:end-8,2);

% first frame difference
imshow(imcomplement( frames(:,:,2)- frames(:,:,1)));

% remove borders from image
set(gca, 'units', 'pixels');
x = get(gca, 'position');
set(gcf, 'units', 'pixels');
y = get(gcf, 'position');
set(gcf, 'position', [y(1) y(2) x(3) x(4)]);
set(gca,'units', 'normalized', 'position', [0 0 1 1]);
%% Step 3 16x16 blocks + Search Area 

testBlock  = blockByBlock16(frames(:,:,2), 1, 4);
testBlock2 = blockByBlockSearch(frames(:,:,1), 1, 4, 7);

%% Step 4 Sample Motion Vector Computation at block (1,1)

[dyTest, dxTest, bestMatchTest] = computeMotionVec(frames(:,:,1), frames(:,:,2), 2, 15, 7);

%% Step 5 Use all function to contruct a Predicted frame from motion vectors

[h,w] = size(frames(:,:,1));

% initialize predicted frame
predictedFrame = zeros(h,w,'uint8');
N = 15;

% fill predicted frame with data using the previous frame + motion vectors 
% adjustment

for x = 1:(w/16)    
    for y = 1:(h/16)
        [dy, dx, bestMatch] = computeMotionVec(frames(:,:,1), frames(:,:,2), y, x, 7);
        temp = blockByBlockSearch(frames(:,:,1), y, x, 7);
        
        if x == 1 && y == 1
            predictedFrame((y*16)-15:(y*16), (x*16)-15:(x*16)) = temp(1+dy:1+N+dy, 1+dx:1+N+dx);
        elseif x == 1
            predictedFrame((y*16)-15:(y*16), (x*16)-15:(x*16)) = temp(8+dy:8+N+dy, 1+dx:1+N+dx);
        elseif y == 1
            predictedFrame((y*16)-15:(y*16), (x*16)-15:(x*16)) = temp(1+dy:1+N+dy, 8+dx:8+N+dx);
        else
            predictedFrame((y*16)-15:(y*16), (x*16)-15:(x*16)) = temp(8+dy:8+N+dy, 8+dx:8+N+dx);
        end
        
        
        if bestMatch ~= predictedFrame((y*16)-15:(y*16), (x*16)-15:(x*16))
            fprintf('Somethings Wrong %d  %d\n', x, y);
        end
        
    end
end

[~,~,entropyPD] = myEntropy(frames(:,:,2) - predictedFrame);
[~,~,entrioySD] = myEntropy(frames(:,:,2) - (frames(:,:,1)));

imshow(imcomplement( frames(:,:,2)- predictedFrame));

entropy1 = DPCM(frames(:,:,2), predictedFrame, 1);
entropy2 = DPCM(frames(:,:,2), predictedFrame, 2);
entropy3 = DPCM(frames(:,:,2), predictedFrame, 3);
entropy4 = DPCM(frames(:,:,2), predictedFrame, 4);

% remove borders from image
set(gca, 'units', 'pixels');
x = get(gca, 'position');
set(gcf, 'units', 'pixels');
y = get(gcf, 'position');
set(gcf, 'position', [y(1) y(2) x(3) x(4)]);
set(gca,'units', 'normalized', 'position', [0 0 1 1]);
%% Part II Content Based Retrieval
%% Step 1 10 - 20 Images

% load some images into matlab workspace
imgDataBase{1}  = imread('green1.jpg');
imgDataBase{2}  = imread('green2.jpg');
imgDataBase{3}  = imread('greenrev.jpg');
imgDataBase{4}  = imread('westconcordaerial.png');
imgDataBase{5}  = imread('fabric.png');
imgDataBase{6}  = imread('pillsetc.png');
imgDataBase{7}  = imread('office_3.jpg');
imgDataBase{8}  = imread('hestain.png');
imgDataBase{9}  = imread('pears.png');
imgDataBase{10} = imread('concordaerial.png');
imgDataBase{11} = imread('football.jpg');
imgDataBase{12} = imread('gantrycrane.png');
imgDataBase{13} = imread('greens.jpg');
imgDataBase{14} = imread('saturn.png');
imgDataBase{15} = imread('tape.png');

%% Step 2 HSV Histograms

% convert to HSV then quantize all 15 images
% !!CPU KILLER!! ~ Took my PC 15 seconds to perform this operation 
hsvImageQuantDataBase = cell(1,15);
for n = 1:15
    hsvImageQuantDataBase{n} = quantHSV(imgDataBase{n});
end

%% Step 2 cont. ~ View histogram for sample image

% calculate histogram
histHSV(hsvImageQuantDataBase{1});

%% Step 2 cont. ~ Merge Histograms 

% get full color histogram for all images
freqData = cell(1,15);
for n = 1:15
    freqData{n} = histData(hsvImageQuantDataBase{n});
end

%% Step 3 Manhattan (city block)

cityBlockArr = zeros(1,15);
cityBlockArr(1) = NaN;
for n = 2:15
    cityBlockArr(n) = cityBlock(freqData{1}, freqData{n});
end
cityBlockArr(2, :) = 1:15;

[~, orderCity] = sort(cityBlockArr(1,:));
cityBlockArr = cityBlockArr(:,orderCity);

%% Step 3 Euclidean Distance

euclid = zeros(1,15);
euclid(1) = NaN;
for n = 2:15
    euclid(n) = euclidean(freqData{1}, freqData{n});
end
euclid(2, :) = 1:15;

[~, orderEuclid] = sort(euclid(1,:));
euclid = euclid(:,orderEuclid);

%% Step 3 Histogram Intersection

intersect = zeros(1,15);
intersect(1) = NaN;
for n = 2:15
    intersect(n) = histIntersection(freqData{1}, freqData{n});
end
intersect(2, :) = 1:15;

[~, orderInterSect] = sort(intersect(1,:));
intersect = intersect(:,orderInterSect);

%% Step 4

freqDataBy8 = cell(1,15);
for n = 1:15
    freqDataBy8{n} = histDataBy8(hsvImageQuantDataBase{n});
end

%% Step 4 Manhattan (city block)

cityBlockArrBy8 = zeros(1,15);
cityBlockArrBy8(1) = NaN;
for n = 2:15
    cityBlockArrBy8(n) = cityBlock(freqDataBy8{1}, freqDataBy8{n});
end
cityBlockArrBy8(2, :) = 1:15;

[~, orderCityBy8] = sort(cityBlockArrBy8(1,:));
cityBlockArrBy8 = cityBlockArrBy8(:,orderCityBy8);

%% Step 4 Euclidean Distance

euclidBy8 = zeros(1,15);
euclidBy8(1) = NaN;
for n = 2:15
    euclidBy8(n) = euclidean(freqDataBy8{1}, freqDataBy8{n});
end
euclidBy8(2, :) = 1:15;

[~, orderEuclidBy8] = sort(euclidBy8(1,:));
euclidBy8 = euclidBy8(:,orderEuclidBy8);

%% Step 4 Histogram Intersection

intersectBy8 = zeros(1,15);
intersectBy8(1) = NaN;
for n = 2:15
    intersectBy8(n) = histIntersection(freqDataBy8{1}, freqDataBy8{n});
end
intersectBy8(2, :) = 1:15;

[~, orderInterSectBy8] = sort(intersectBy8(1,:));
intersectBy8 = intersectBy8(:,orderInterSectBy8);



