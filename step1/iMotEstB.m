function [mBY, mBCr, mBCb] = iMotEstB(eMBY, eMBCr, eMBCb, mBIndex, mV, backwFrameY, backwFrameCr, backwFrameCb, ...
                                    forwFrameY, forwFrameCr, forwFrameCb)
%% Inverse of Motion Estimation for B-frames
%   Inputs:
%   eMBxx: prediction errors (y,Cr,Cb)
%   mbIndex:marcoblock index number
%   mV: motion Vectors
%       second column is NaN due to no reference in future frame
%   backwFramexx: reference Y,Cr,Cb components
%   forwFramexx: reference Y,Cr,Cb components
%  
%   Outputs:
%   mBxx: macroblock Y,Cb,Cr componets
%%
x_shift_b=mV(1,1);  %value of shifting the reference frame using motion Vector
y_shift_b=mV(2,1);
x_shift_f=mV(1,2); 
y_shift_f=mV(2,2);

x_FrameY=mod(mBIndex,22)*16+1;%starting pixels backward
y_FrameY=floor(mBIndex/22)*16+1;
x_FrameCr=mod(mBIndex,22)*8+1;
y_FrameCr=floor(mBIndex/22)*8+1;
x_FrameCb=mod(mBIndex,22)*8+1;
y_FrameCb=floor(mBIndex/22)*8+1;



estmBY=backwFrameY(y_FrameY+y_shift_b:(y_FrameY+15)+y_shift_b,x_FrameY+x_shift_b:(x_FrameY+15)+x_shift_b);  %estimated reference macroblock
estmBY=double(estmBY);%converting to double to substract error
estmBY_f=forwFrameY(y_FrameY+y_shift_f:(y_FrameY+15)+y_shift_f,x_FrameY+x_shift_f:(x_FrameY+15)+x_shift_f);  %estimated reference macroblock
estmBY_f=double(estmBY_f);%converting to double to substract error

mBY=(0.5)*(estmBY+estmBY_f)-eMBY;
mBY = uint8(mBY);% converting to uint8

esmBCr=backwFrameCr(y_FrameCr+y_shift_b:(y_FrameCr+7)+y_shift_b,x_FrameCr+x_shift_b:(x_FrameCr+7)+x_shift_b);
esmBCr=double(esmBCr);
estmBCr_f=forwFrameCr(y_FrameCr+y_shift_f:(y_FrameCr+7)+y_shift_f,x_FrameCr+x_shift_f:(x_FrameCr+7)+x_shift_f);  %estimated reference macroblock
estmBCr_f=double(estmBCr_f);%converting to double to substract error

mBCr=(0.5)*(esmBCr+estmBCr_f)-eMBCr;
mBCr = uint8(mBCr);

esmBCb=backwFrameCb(y_FrameCb+y_shift_b:(y_FrameCb+7)+y_shift_b,x_FrameCb+x_shift_b:(x_FrameCb+7)+x_shift_b);
esmBCb=double(esmBCb);
estmBCb_f=forwFrameCb(y_FrameCb+y_shift_f:(y_FrameCb+7)+y_shift_f,x_FrameCb+x_shift_f:(x_FrameCb+7)+x_shift_f);  %estimated reference macroblock
estmBCb_f=double(estmBCb_f);%converting to double to substract error

mBCb=(0.5)*(esmBCb+estmBCb_f)-eMBCr;
mBCb = uint8(mBCb);

figure;
subplot(3,1,1);
imshow(mBY);
subplot(3,1,2);
imshow(mBCb);
subplot(3,1,3);
imshow(mBCr);

end

