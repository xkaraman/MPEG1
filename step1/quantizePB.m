function [qBlock] = quantizePB(dctBlock, qTable, qScale)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

qBlock = floor( 8 * dctBlock ./ (qScale * qTable) );


end

