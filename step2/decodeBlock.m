function decBlock = decodeBlock(encBlock, mBType,qScale)
% Inputs:
% encBlock: Encoded block to be decoded.
% mBType: Macroblock Type.
% qScale: Quantization Scale.
% 
% Output:
% decBlock: Decoded block. matrix 8 × 8.

persistent dqI dqPB;

if isempty(dqI)
    dqI = qintra;
    dqPB = qinter;
end

c = encBlock.VLCodes; % Read VL Coded block from file

c = ivlc(c); % Decode VLC

c = iRunLength(c);

if strcmp(mBType,'001')
    qTable = dqI;
    dct = dequantizeI(c, qTable, bin2dec( qScale) );
else
    qTable = dqPB;
    dct = dequantizePB(c, qTable, bin2dec(qScale) );
end

decBlock = iBlockDCT(dct);


end

%%
function q = qintra
% Quantization table for I frames

q = [ 8 16 19 22 26 27 29 34;
     16 16 22 24 27 29 34 37;
     19 22 26 27 29 34 34 38;
     22 22 26 27 29 34 37 40;
     22 26 27 29 32 35 40 48;
     26 27 29 32 35 40 48 58;
     26 27 29 34 38 46 56 69;
     27 29 35 38 46 56 69 83 ];
end 
%%
function q = qinter
% Quantization table for P or B frames

% q = repmat(16,8,8);
q = 16;
end
