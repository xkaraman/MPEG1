
frameRGB=imread('coastguard001.tiff');
[frameY, frameCr, frameCb] = ccir2ycrcb(frameRGB);
[frameRGB1] = ycrcb2ccir(frameY, frameCr, frameCb);
figure;
subplot(2,1,1);
imshow(frameRGB);
title('original picture RGB');
subplot(2,1,2);
imshow(frameRGB1);
title('reconstructed picture from YCbCr');

mBIndex=0;
t1=imread('coastguard001.tiff');
t3=imread('coastguard003.tiff');
[refFrameY, refFrameCr, refFrameCb] = ccir2ycrcb(t1);
[frameY, frameCr, frameCb] = ccir2ycrcb(t3);
[eMBY, eMBCr, eMBCb, mV] = motEstP(frameY, frameCr, frameCb, mBIndex,refFrameY, refFrameCr, refFrameCb);
[mBY, mBCr, mBCb] = iMotEstP(eMBY, eMBCr, eMBCb, mBIndex, mV,refFrameY, refFrameCr, refFrameCb);
subplot(2,1,1);
imshow(uint8(frameY(1:16,1:16)));
title('original macroblock Y before motion est-P');
subplot(2,1,2);
imshow(mBY);
title('reconstructed macroblock Y after motion est-P');



t4=imread('coastguard004.tiff');
[forwFrameY, forwFrameCr, forwFrameCb] = ccir2ycrcb(t4);
[eMBY, eMBCr, eMBCb, mV] = motEstB(frameY, frameCr, frameCb, mBIndex, ...
 refFrameY, refFrameCr, refFrameCb,forwFrameY, forwFrameCr, forwFrameCb);

[mBY, mBCr, mBCb] = iMotEstB(eMBY, eMBCr, eMBCb, mBIndex, mV, refFrameY, refFrameCr, refFrameCb, ...
forwFrameY, forwFrameCr, forwFrameCb);

subplot(2,1,1);
imshow(uint8(frameY(1:16,1:16)));
title('original macroblock Y before motion est-B');
subplot(2,1,2);
imshow(mBY);
title('reconstructed macroblock Y after motion est-B');

block=mBY(1:8,1:8);
disp('DCT matrix');
[dctBlock] = blockDCT(block);
dctBlock
qScale=8;
qTable = [ 8 16 19 22 26 27 29 34;
     16 16 22 24 27 29 34 37;
     19 22 26 27 29 34 34 38;
     22 22 26 27 29 34 37 40;
     22 26 27 29 32 35 40 48;
     26 27 29 32 35 40 48 58;
     26 27 29 34 38 46 56 69;
     27 29 35 38 46 56 69 83 ]; %%apo to protipo

[qBlock] = quantizeI(dctBlock, qTable, qScale);

[dctBlock] = dequantizeI(qBlock, qTable, qScale);

disp('DCT matrix after quant and dequant');
dctBlock

[runSymbols] = runLength(qBlock);
disp('Run Symbols Before');
runSymbols

[vlcStream] = vlc(runSymbols)

 [runSymbols] = ivlc(vlcStream)
disp('Run Symbols after');
runSymbols

