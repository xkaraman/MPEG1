function SeqEntity = encodeMPEG(bName, fExtension, startFrame, GoP, numOfGoPs, qScale)

% genSeqHeader % Generate the header of the sequence
% 3 writeSeqHeader
% 4 encodeSeq
% 5 writeSeqEnd

%   SeqHeader sequence_header_code 32 bslbf
%             horizontal_size 12 uimsbf
%             vertical_size 12 uimsbf
%   SeqEnd sequence_end_code 32 bslbf

seq_header = '0000 0000 0000 0000 0000 0001 1011 0011';
vertical = dec2bin(720);
horizontal = dec2bin(584);

SeqHeader = struct('sequence_header_code',seq_header,...
                 'horizontal_size',horizontal,...
                 'vertical_size',vertical);

GoPEntityArray = encodeSeq(bName, fExtension, startFrame, GoP, numOfGoPs, qScale);

seq_end = '0000 0000 0000 0000 0000 0001 1011 0111';

% how to save it
SeqEntity = struct('SeqHeader',SeqHeader,...
                   'GoPEntityArray',GoPEntityArray,...
                   'Seq_End',seq_end );

end

