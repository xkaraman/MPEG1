function [ MotionVectors,BlockEntityArray ] = encodeMB( pic, picType,qScale, mbIndex )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% Encode according to Frame/Macroblock Type
switch (picType)
    case 'P'
        motEstP()
        %encodeMV()
    case 'I'
        motEstB()
        %encodeMV()
end

% Encode it's 6 blocks, 4 Luma 2 Chroma
blocks = zeros(6,1);
for bindex=1:6
    blocks(bindex) = encodeBlock(,picType,qScale);
end

end

