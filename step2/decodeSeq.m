function decodeSeq(GoPEntityArray, outFName)
% bName: Το πρόθεμα του ονόματος των αποκωδικοποιημένων εικόνων.
% GoPEntityArray: Πίνακας από δομές τύπου GoPEntity .
% Παρατηρήσεις/απλουστεύσεις:
% 1. Εδώ φορτώνεται η αποθηκευμένη δομή του κωδικοποιημένου βίντεο.



for i=1:length(GoPEntityArray.PicSliceEntityArray)

% readGoPHeader

decodeGoP(GoPEntityArray.PicSliceEntityArray,outFName);

end

end