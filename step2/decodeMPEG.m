function decodeMPEG(fName, outFName)
%fName= .mat file with the encoded sequence
%  decoded frames -> [outFName, frame_number, '.tiff'].

% function decodeMPEG
% 2 readSeqHeader
% 3 decodeSeq

load(fName);
decodeSeq(SeqEntity.GoPEntityArray, outFName)
%picture_name=sprintf('%s%03d.%s', bName,startFrame,fExtension);


end

