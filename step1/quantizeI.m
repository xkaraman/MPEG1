function [qBlock] = quantizeI(dctBlock, qTable, qScale)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


% Quantization table for I frames

% q = [ 8 16 19 22 26 27 29 34;
%      16 16 22 24 27 29 34 37;
%      19 22 26 27 29 34 34 38;
%      22 22 26 27 29 34 37 40;
%      22 26 27 29 32 35 40 48;
%      26 27 29 32 35 40 48 58;
%      26 27 29 34 38 46 56 69;
%      27 29 35 38 46 56 69 83 ];
%  
 

    qBlock = floor( 8 * dctBlock ./ (qScale * qTable) );
    qBlock(1,1) = round( dctBlock (1,1)/ 8 );
end

