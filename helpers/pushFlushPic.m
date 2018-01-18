function pushFlushPic(pic, tempRef, outFName)
% Inputs:
%   pic: Picture to be stored. Structrure(frameY, frameCr, frameCb)
%   tempRef: Display order number. PicSliceEntityHeader.temporal_reference
%   outFName: Base name to be stored

% Used by decodeGoP to store image in disk.

out = sprintf('%s%03d%s',outFName,tempRef,'.tiff');
imwrite(uint8(pic),out);

end

