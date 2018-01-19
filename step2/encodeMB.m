function [ MotionVectors, BlockEntityArray ] = encodeMB( pic, picType, qScale, mbIndex )
%   Inputs:
%   pic: frame/picture to be encoded
%   picType: picture Type ( I,P,B)
%   qScale: quantization scale
%   mbIndex: macroblock index to be encoded
% 
%   Output:
%   MotionVectors
%   BlockEntityArray

global buf;

% Encode according to Frame/Macroblock Type
 switch (picType)
    case 'P'
         mv = motEstP(pic.frameY,pic.frameCr,pic.frameCb,mbIndex,...
                      buf(1).frameY,buf(1).frameCr,buf(1).frameCb);
%         encodeMV()
    case 'B'
        mv = motEstB (pic.frameY,pic.frameCr,pic.frameCb,mbIndex,...
                      buf(1).frameY,buf(1).frameCr,buf(1).frameCb,...
                      buf(2).frameY,buf(2).frameCr,buf(2).frameCb);
%         encodeMV()
     otherwise
         mv = [NaN NaN; NaN NaN];
end

% Get Macroblock matrices according to its mbIndex

xi = mod( mbIndex * 16, size(pic.frameY,2) );
yi = floor( mbIndex * 16 / size(pic.frameY,2) ) * 16;

b = zeros([8, 8, 6]);

% Four lum blocks
b(:,:,1) = pic.frameY( yi+1:yi+8 ,xi+1:xi+8 );
b(:,:,2) = pic.frameY( yi+1:yi+8 ,xi+9:xi+16 );
b(:,:,3) = pic.frameY( yi+9:yi+16 ,xi+1:xi+8 );
b(:,:,4) = pic.frameY( yi+9:yi+16 ,xi+9:xi+16 );

% Two chroma blocks
b(:,:,5) = pic.frameCb( yi/2+1:yi/2+8 ,xi/2+1:xi/2+8 );
b(:,:,6) = pic.frameCr( yi/2+1:yi/2+8 ,xi/2+1:xi/2+8 );

% Encode it's 6 blocks, 4 Luma 2 Chroma
blocks = struct( 'VLCodes', [] );

for bindex=1:6
    blocks(bindex) = encodeBlock( b(:,:,bindex), picType, qScale );
end
BlockEntityArray = blocks;
MotionVectors= mv;
end

