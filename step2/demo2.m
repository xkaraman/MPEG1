clearvars

bName = 'coastguard';
fExtension = 'tiff';
startFrame = 0;
GoP = 'IBPBBP';
numOfGoPs = 1;
qScale = 5;

im1=imread('coastguard001.tiff');
im2=imread('coastguard002.tiff');
im3=imread('coastguard003.tiff');
im4=imread('coastguard004.tiff');
im5=imread('coastguard005.tiff');
im6=imread('coastguard006.tiff');

[r, c, d] = size(im1);
s= r*c*d*8;
s = s/8*6;

tic
SeqEntity = encodeMPEG(bName,fExtension,startFrame,GoP,numOfGoPs,qScale);
toc
disp('Encoding done');
bits = getSeqEntityBits(SeqEntity)/8;

tic
decodeMPEG('encoded.mat', 'polimesa');
toc
disp('Decoding done');
