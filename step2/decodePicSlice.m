function decPic = decodePicSlice(MBEntityArray)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
m=0;
numOfMB=length(MBEntityArray);
for mBIndex = 1:numOfMB
    
    [mby,mbcr,mbcb] = decodeMB(MBEntityArray(mBIndex).BlockEntityArray,...
                               MBEntityArray(mBIndex).MotionVectors,...
                               MBEntityArray(mBIndex).MBHeader.macroblock_type, ...
                               mBIndex-1, ...
                               MBEntityArray(mBIndex).MBHeader.quantizer_scale);
    
    
    %creating the horizontals mosaics of the image
    if mod(mBIndex,22) == 1
        mosaicY{floor(mBIndex/22)+1}=mby;
        mosaicCb{floor(mBIndex/22)+1}=mbcb;
        mosaicCr{floor(mBIndex/22)+1}=mbcr;
        m=m+1;
    else
        mosaicY{m}=[mosaicY{m} mby];
        mosaicCb{m}=[mosaicCb{m} mbcb];
        mosaicCr{m}=[mosaicCr{m} mbcr];
    end
end

% Adding horizontal mosaics to form full image
Y=mosaicY{1};
Cb=mosaicCb{1};
Cr=mosaicCr{1};
for i=2:18
    
    Y=[Y; mosaicY{i} ];
    Cb=[Cb; mosaicCb{i} ];
    Cr=[Cr; mosaicCr{i} ];
    
end



decPic.frameY=Y;
decPic.frameCb=Cb;
decPic.frameCr=Cr;
end

