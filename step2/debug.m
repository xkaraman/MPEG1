clearvars
close all
bName = 'coastguard';
fExtension = 'tiff';
startFrame = 0;
GoP = 'IBPBBP';
numOfGoPs = 1;
qScale = 5;

im1=imread('coastguard003.tiff');
im1=imresize(im1,[288 352]);

block = im1(1:8,11*16+1:11*16+8);

encblock=encodeBlock(block,'I',5);

decblock = uint8(decodeBlock(encblock,'001','0101'));

figure
subplot(1,3,1)
imshow(block)
subplot(1,3,2)
imshow(uint8(decblock))
subplot(1,3,3)
imshowpair(uint8(decblock),block,'diff')


pic.frameY=im1(:,:,1);
pic.frameCb=im1(:,:,2);
pic.frameCr=im1(:,:,3);

mb = pic.frameY(1:16,1:16);

[mv,encmb]=encodeMB(pic,'I',5,0);

[decmbY,decmbCr,decmbCb] = decodeMB(encmb,mv,'001',0,'101');

figure
subplot(1,3,1)
imshow(mb)
subplot(1,3,2)
imshow(decmbY)
subplot(1,3,3)
imshowpair(mb,decmbY,'diff')

pic.frameY=imresize( im1(:,:,1), [288 352] );
pic.frameCb=imresize( im1(:,:,2), [144 176] );
pic.frameCr=imresize( im1(:,:,3), [144 176] );

encpic = encodePicSlice(pic,'P',8);

decpic = decodePicSlice(encpic);



