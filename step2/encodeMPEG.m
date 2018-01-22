function SeqEntity = encodeMPEG(bName, fExtension, startFrame, GoP, numOfGoPs, qScale)

% genSeqHeader % Generate the header of the sequence
% 3 writeSeqHeader
% 4 encodeSeq
% 5 writeSeqEnd

%   SeqHeader sequence_header_code 32 bslbf
%             horizontal_size 12 uimsbf
%             vertical_size 12 uimsbf
%   SeqEnd sequence_end_code 32 bslbf

seq_header = dec2bin( hex2dec('000001B3'),32);
vertical = dec2bin(720,12); 
horizontal = dec2bin(584,12);

SeqHeader = struct('sequence_header_code',seq_header,...
                   'horizontal_size',horizontal,...
                   'vertical_size',vertical);

GoPEntityArray = encodeSeq(bName, fExtension, startFrame, GoP, numOfGoPs, qScale);

seq_end = dec2bin( hex2dec('000001B7'),32);

% how to save it
SeqEntity = struct('SeqHeader',SeqHeader,...
                   'GoPEntityArray',GoPEntityArray,...
                   'SeqEnd',seq_end );

save('encoded.mat','SeqEntity');
end

