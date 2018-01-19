function [decMBY,decMBCr,decMBCb] = decodeMB(BlockEntityArray, MotionVectors, ...
    mBType, mBIndex, qScale )
% Inputs:
% BlockEntityArray: Array of BlockEntity structures.
% MotionVectors: Array of Motion Vectors
% mBType: Macroblock Type.
% mBIndex: Current macroblock index.
% qScale: Quantization scale.
%
% Outputs:
% decMBY,decMBCr,decMBCb: Y , Cr, Cb channels of decoded macroblock.
%                       Arrays of 16x16,8x8,8x8 respectively
%

global buf;

if mBType == 2 || mBType ==  3 % Read motion vectors if necessary
    mv = MotionVectors;
    %     readMV
end

% x = zeros(1,6);
for bIndex = 1:6
    %     readBHeader
    x(bIndex) = decodeBlock(BlockEntityArray(bIndex),mBType, qScale);
end

erry = [x(1) x(2) ; x(3) x(4)];
errcb = x(5);
errcr = x(6);
switch (mBType)
    case 2
        [mbY, mbCr, mbCB] = imotestP(erry,errcr,errcb , mv,...
            buf(1).frameY,buf(1).frameCr,buf(1).frameCb);
        
        decMBY = mbY;
        decMBCb = mbCr;
        decMBCr = mbCB;
    case 3
        [mbY, mbCr, mbCB] = imotestB(erry,errcr,errcb,mBIndex, mv,...
            buf(1).frameY,buf(1).frameCr,buf(1).frameCb,...
            buf(2).frameY,buf(2).frameCr,buf(2).frameCb);
        
        decMBY = mbY;
        decMBCb = mbCr;
        decMBCr = mbCB;
    case 1
        decMBY = erry;
        decMBCb = errcb;
        decMBCr = errcr;
end
end

