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

% Encode according to Frame/Macroblock Type
% %switch (picType)
%     case 'P'
%         mv = motEstP();
        %encodeMV()
%     case 'I'
%         mv = motEstB();
        %encodeMV()
% end

% Get Macroblock matrices according to its mbIndex

xi = mod( mbIndex * 16, size(pic.y,2) );
%if ( floor( mbIndex * 16 / 352) > 0 )
yi = floor( mbIndex * 16 / size(pic.y,2) ) * 16;
%else
%   yi = 0;
%end

b = zeros([8, 8, 6]);

% Four lum blocks
b(:,:,1) = pic.y( yi+1:yi+8 ,xi+1:xi+8 );
b(:,:,2) = pic.y( yi+1:yi+8 ,xi+9:xi+16 );
b(:,:,3) = pic.y( yi+9:yi+16 ,xi+1:xi+8 );
b(:,:,4) = pic.y( yi+9:yi+16 ,xi+9:xi+16 );

% Two chroma blocks
b(:,:,5) = pic.cb( yi/2+1:yi/2+8 ,xi/2+1:xi/2+8 );
b(:,:,6) = pic.cr( yi/2+1:yi/2+8 ,xi/2+1:xi/2+8 );

% Encode it's 6 blocks, 4 Luma 2 Chroma
blocks = struct( 'VLCodes', [] );

for bindex=1:6
    blocks(bindex) = encodeBlock( b(:,:,bindex), picType, qScale );
end
BlockEntityArray = blocks;
%% TODO Motion Vectors
MotionVectors=[1 2;3 4];
end

