function [ MBEntityArray ] = encodePicSlice( pic, picType, qScale )
% Inputs:
% pic: frame to be encoded as returned by getNextPicture. 
%      Matlab structure with 3 components(pic.frameY,pic.frameCr,
%      ic.frameCb) of size 352*288,176*144,176*144 respectively
% picType: pictureType (I,P,B)
% qScale: quantization scale
% 
% Output:
%  MBEntityArray

    mb = struct('MBHeader',[],'MotionVectors',[],'BlockEntityArray',[]);
for mbindex = 1:( size(pic.frameY,1) / 16 )* ( size(pic.frameY,2) / 16 )
    mb(mbindex).MBHeader = genMBheader(picType,qScale); 
%     writeMBheader()
    [mb(mbindex).MotionVectors, mb(mbindex).BlockEntityArray] =  encodeMB(pic,picType,qScale,mbindex-1);
%     writeMV
%     wrtieMBend()
end

MBEntityArray=mb;

end

function h = genMBheader(type,scale)
    if type == 'I'
    h.macroblock_type = dec2bin(1);
    elseif type == 'P'
        h.macroblock_type = dec2bin(2);
    else
        h.macroblock_type = dec2bin(3);
    end
    h.quantizer_scale = dec2bin(scale); 
end
