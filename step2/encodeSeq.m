function GoPEntityArray = encodeSeq(bName, fExtension, startFrame, GoP, numOfGoPs, qScale)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% function encodeSeq
% 2 while true
% 3 genGoPHeader
% 4 writeGoPHeader
% 5 t = encodeGoP
% 6 if t == 0
% 7 break % Unexpected end of GoP found, assuming end of sequence
% 8 end
% 9 end


% GoPEntity GoPHeader (1)
%           PicSliceEntityArray(GoP size)
%           PicSliceEntity

% GoPHeader group_start_code 32 bslbf
frameNumber=startFrame;
GoPHeader= dec2bin( hex2dec('1B8'), 32);
% GoPEntityArray.GoPHeader=GoPHeader;
 for gop = 1:numOfGoPs
[t, PicSliceEntityArray] = encodeGoP(frameNumber, bName, fExtension, startFrame, GoP, qScale);
if t==0
    break;% Unexpected end of GoP found, assuming end of sequence
end
frameNumber=frameNumber+size(GoP,2);% gia kathe epomeno Gop to proto frame tha ine metatopismeno kata to size tou Gop
GoPEntityArray(gop).GoPHeader=GoPHeader;
GoPEntityArray(gop).PicSliceEntityArray = PicSliceEntityArray;

 end
 
%  GoPEntityArray.PicSliceEntityArray=PicSliceEntityArrays;
 
end

