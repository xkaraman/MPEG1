function decodeGoP(PicSliceEntityArray, outFName)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

sizeOfoP=length(PicSliceEntityArray)
% function decodeGoP
% 2 for picIndex = 1:sizeOfoP
% 3 readPicSliceHeader
% 4 dPic = decodePicSlice
% 5 if isempty(dPic)
% 6 return(0) % No picture found
% 7 end
% 8 pushFlushPic % Send picture to output buffer
% 9 if picType == I || P
% 10 pushPic % Save to picture buffer for future reference
% 11 end
% 12 end

for picIndex = 1:sizeOfoP
    dPic = decodePicSlice(PicSliceEntityArray(picIndex).MBEntityArray);
    picType=PicSliceEntityArray(picIndex).PicSliceHeader.picture_coding_type
    if isempty(dPic)
        return; % No picture found
    end
    pushFlushPic(dPic, picIndex, outFName);
    
     picType=PicSliceEntityArray(picIndex).PicSliceHeader.picture_coding_type
    if picType == '001' || picType == '010'   % if it is I or P frame
%              % Save to picture buffer for future reference
        pushPic( dPic ); 
     end
    
end

end

