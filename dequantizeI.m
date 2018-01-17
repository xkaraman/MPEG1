function [dctBlock] = dequantizeI(qBlock, qTable, qScale)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

dctBlock = qBlock .* (qScale * qTable) / 8;


end

