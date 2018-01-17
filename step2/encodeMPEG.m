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
%   genSeqHeader
%   writeSeqHeader
%   encodeSeq
%   writeSeqEnd

end

