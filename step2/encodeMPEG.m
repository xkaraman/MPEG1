function encodeMPEG( bName, fExtension, startFrame, GoP, numOfGoPs, qscale )

%   GoP and qScale remain constant throughout the encoding
%   GoP start with I-frames and end with I or P-frames

% Get frames
i=1;
while(true)
    imgname = sprintf('%s%03d.%s',bName,i-1,fExtension);
    imgname = fullfile('../src/',imgname);
    if ( exist( imgname ,'file') == 2)
       images{i} = imread(imgname);
    else
        break
    end
    i = i +1;
end

   genSeqHeader(images{1})
%   writeSeqHeader
%   encodeSeq
%   writeSeqEnd

end

function genSeqHeader(x)
    SeqHeader = struct('sequence_header_code',[],'horizontal_size',[],'vertical_size',[]);
    SeqHeader.sequence_header_code =  dec2bin( hex2dec('000001B3') );
    SeqHeader.horizontal_size = dec2bin( size(x,2) );
    SeqHeader.vertical_size = dec2bin( size(x,1) );
end
