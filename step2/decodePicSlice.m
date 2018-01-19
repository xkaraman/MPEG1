function decPic = decodePicSlice(MBEntityArray)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

numOfMB=length(MBEntityArray)
 for mBIndex = 1:numOfMB
         
[decMBY(mBIndex),decMBCr(mBIndex),decMBCb(mBIndex)] = decodeMB(MBEntityArray(mBIndex).BlockEntityArray,...
 MBEntityArray(mBIndex).MotionVectors, MBEntityArray(mBIndex).MBHeader.macroblock_type, ...
 mBIndex, MBEntityArray(mBIndex).MBHeader.quantizer_scale)


%creating the horizontals mosaics of the image
if mod(mBindex,22)=1
mosaicY(floor(mBindex/22)+1)=decMBY(mBIndex);
mosaicCb(floor(mBindex/22)+1)=decMBCb(mBIndex);
mosaicCr(floor(mBindex/22)+1)=decMBCr(mBIndex);
else
mosaicY(floor(mBindex/22)+1)=[mosaicY(floor(mBindex/22)+1) decMBY(mBIndex)];
mosaicCb(floor(mBindex/22)+1)=[mosaicCb(floor(mBindex/22)+1) decMBCb(mBIndex)];
mosaicCr(floor(mBindex/22)+1)=[mosaicCr(floor(mBindex/22)+1) decMBCr(mBIndex)];
end
 end
 
 % Adding horizontal mosaics to form full image
Y(1)=mosaicY
Cb(1)=mosaicCb
Cr(1)=mosaicCr
 for i=2:18
 
Y(i)=[Y(i);mosaicY(i) ];
Cb(i)=[Cb(i);mosaicCb(i) ];
Cr(i)=[Cr(i);mosaicCr(i) ];
 
 end
 


decPic.frameY=Y;
decPic.frameCb=Cb;
decPic.frameCr=Cr;
end

