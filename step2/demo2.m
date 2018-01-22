clearvars

bName = 'coastguard';
fExtension = 'tiff';
startFrame = 0;
GoP = 'IBPBBP';
numOfGoPs = 1;
qScale = 5;

im1=imread('coastguard000.tiff');
im2=imread('coastguard001.tiff');
im3=imread('coastguard002.tiff');
im4=imread('coastguard003.tiff');
im5=imread('coastguard004.tiff');
im6=imread('coastguard005.tiff');

[r, c, d] = size(im1);
s = r*c*d*8;
s = s/8*6;

disp('Encoding... May take a while');
tic
SeqEntity = encodeMPEG(bName,fExtension,startFrame,GoP,numOfGoPs,qScale);
toc
disp('Encoding done');
bits = getSeqEntityBits(SeqEntity)/8;

disp('Bytes for 6 pictures');
s
disp('Bytes for 6 encoded pictures');
bits

disp('Decoding... May take a little longer');
tic
decodeMPEG('encoded.mat', 'polimesa');
toc
disp('Decoding done');

dec1 = imread('polimesa001.tiff');
dec2 = imread('polimesa002.tiff');
dec3 = imread('polimesa003.tiff');
dec4 = imread('polimesa004.tiff');
dec5 = imread('polimesa005.tiff');
dec6 = imread('polimesa006.tiff');

d = abs(im1-dec1);
d1 = mean(d(:));
d = abs(im2-dec2);
d2 = mean(d(:));
d = abs(im3-dec3);
d3 = mean(d(:));
d = abs(im4-dec4);
d4 = mean(d(:));
d = abs(im5-dec5);
d5 = mean(d(:));
d = abs(im6-dec6);
d6 = mean(d(:));

disp('To meso apolito sfalma ana eikona')
d = [d1 d2 d3 d4 d5 d6 ]

im3=imread('coastguard002.tiff');
[y,cr,cb]=ccir2ycrcb(im3);

figure
imshow(y);
title('Y Component of coastguard.tiff');

% pic.frameY = y;
% pic.frameCb = cb;
% pic.frameCr = cr;

% encpic = encodePicSlice(pic,'P',8);

% decpic = decodePicSlice(encpic);

