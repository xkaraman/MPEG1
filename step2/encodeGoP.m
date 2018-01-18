function [t, PicSliceEntityArray] = encodeGoP(frameNumber, bName,...
    fExtension,startFrame, GoP, qScale)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% function encodeGoP
% 2 for picIndex = 1:sizeOfGoP
% 3 pic = getNextPic % Get next picture
% 4 if isempty(pic)
% 5 return(0) % No picture found
% 6 end
% 7 genPicSliceHeader % Generate headers for picture and slice
% 8 writePicSliceHeader
% 9 encodePicSlice
% 10 if picType == I || P
% 11 decodePicSlice
% 12 pushPic % Save to picture buffer for future reference
% 13 end
% 14 end
% 15 return(1)

% PicSliceHeader picture_start_code 32 bslbf
%          temporal_reference 10 uimsbf
%         picture_coding_type 3 uimsbf (1, 2, 3 για I, P, B frames αντίστοιχα)
%         slice_start_code 32 bslbf
%         quantizer_scale 5 uimsbf
temporal_reference=-1;
startFrame=frameNumber; % efoson asxoloumaste me ena sigkekrimeno Gop, theloume na exume refference to proto frame tou
%to FrameNumber tha xrisimopiithi gia tin metavasi se epomena frames
for picIndex = 1:sizeOfGoP
[pic, picType, tempRef] = getNextPicture(bName, fExtension, frameNumber,...  % Get next picture
    startFrame, GoP)
    if isempty(pic)
        t=0;% No picture found
    end
    % ---Generate headers for picture and slice----
    picture_start_code='0000 0000 0000 0000 0000 0001 0000 0000'; 
    temporal_reference=tempRef; % first picture =0 and on;
    current_coding_type=picType;
    
    switch current_coding_type
    case 'I' 
        picture_coding_type=1;
    case 'P'  
        picture_coding_type=2;  
    case 'B'  
        picture_coding_type=3; 
    end
    
    slice_start_code='0000 0000 0000 0000 0000 0001 0000 0001 '; % Efoson kodikopioume panta me to idio q tote den exei noima na exume polla slices. ena slice exei ola ta MB tis ikonas
    quantizer_scale=qScale ;
   % ---Generate headers for picture and slice----
   
    PicSliceHeader=struct('picture_start_code',picture_start_code,'temporal_reference',temporal_reference,...
        'current_coding_type',current_coding_type,'picture_coding_type',picture_coding_type,...
        'slice_start_code',slice_start_code,'quantizer_scale',quantizer_scale);


MBEntityArray(picIndex) = encodePicSlice(pic, picType, qScale)
if picType == I || P
 decPic = decodePicSlice(MBEntityArray)
pushPic(pic) % Save to picture buffer for future reference
end
 
frameNumber=frameNumber+1;
end

 PicSliceEntityArray.PicSliceHeader=PicSliceHeader;
 PicSliceEntityArray.MBEntityArray=MBEntityArray;
         
    
end

