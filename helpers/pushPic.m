function pushPic(pic)
% Inputs:
% pic: Picture to be saved in buffer.
global buf;

if isempty(buf)
    buf= pic;
elseif length(buf) == 1
    buf(2) = pic;
else
    buf(1) = buf(2);
    buf(2) = pic;
end



end

