function [ BlockEntity ] = encodeBlock( blockMatrix, mBType, qscale )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% Define quantization tables for quantizeI and quantizePB functions with
% default of MPEG standard

% memory preserved between function calls
persistent qI qPB;

if isempty(qI)
    qI = qintra;
    qPB = qinter;
end

% DCT coefficients
C=blockDCT(blockMatrix);

% Quantize accordind to Frame/Block Type
if(mBType == 'I')
    q=qI;
    c=quantizeI(C,q,qscale);
else
    q=qPB;
    c=quantizePB(C,q,scale);
end

% Run/Level Zig-Zag Scanning
symbols=runLength(c);
% Encode them using Variable Length Code defaults by MPEG1 standard
BlockEntity.VLCodes=vlc(symbols);
% writeVLC();
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

