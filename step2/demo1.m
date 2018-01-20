clearvars

bName = 'coastguard';
fExtension = 'tiff';
startFrame = 0;
GoP = 'IBPBBP';
numOfGoPs = 1;
qScale = 10;

SeqEntity = encodeMPEG(bName,fExtension,startFrame,GoP,numOfGoPs,qScale);

decodeMPEG('encoded.mat', 'polimesa');