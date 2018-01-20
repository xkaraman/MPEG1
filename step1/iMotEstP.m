function [mBY, mBCr, mBCb] = iMotEstP(eMBY, eMBCr, eMBCb, mBIndex, mV,refFrameY, refFrameCr, refFrameCb)
%% Inverse of Motion Estimation for P-frames
%   Inputs:
%   eMBxx: prediction errors
%   mbIndex:marcoblock index number
%   mV: motion Vectors
%       second column is NaN due to no reference in future frame
%   refxx: reference Y,Cb,Cr components
%   
%  
%   Outputs:
%   mBxx: macroblock Y,Cb,Cr componets

%% Inverse Motion
% value of shifting the reference frame using motion Vector 
y_shift=mV(2,1);
x_shift=mV(1,1);
x_FrameY=mod(mBIndex,22)*16+1;%starting pixels
y_FrameY=floor(mBIndex/22)*16+1;
x_FrameCr=mod(mBIndex,22)*8+1;
y_FrameCr=floor(mBIndex/22)*8+1;
x_FrameCb=mod(mBIndex,22)*8+1;
y_FrameCb=floor(mBIndex/22)*8+1;


estmBY=refFrameY(y_FrameY+y_shift:(y_FrameY+15)+y_shift,x_FrameY+x_shift:(x_FrameY+15)+x_shift);  %estimated reference macroblock
estmBY=double(estmBY);%converting to double to substract error
mBY=estmBY-eMBY; %correcting the prediction using the error 
mBY = uint8(mBY);% converting to uint8

esmBCr=refFrameCr(y_FrameCr+y_shift:(y_FrameCr+7)+y_shift,x_FrameCr+x_shift:(x_FrameCr+7)+x_shift);
esmBCr=double(esmBCr);
mBCr=esmBCr-eMBCr;
mBCr = uint8(mBCr);

esmBCb=refFrameCb(y_FrameCb+y_shift:(y_FrameCb+7)+y_shift,x_FrameCb+x_shift:(x_FrameCb+7)+x_shift);
esmBCb=double(esmBCb);
mBCb=esmBCb-eMBCb;
mBCb = uint8(mBCb);



end

