function [eMBY, eMBCr, eMBCb, mV] = motEstB(frameY, frameCr, frameCb, mBIndex, ...
 backwFrameY, backwFrameCr, backwFrameCb,forwFrameY, forwFrameCr, forwFrameCb)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%--------- Y-Motion Estimation ----------

x_FrameY=mod(mBIndex,22)*16+1;%starting pixels
y_FrameY=floor(mBIndex/22)*16+1;
x_FrameCr=mod(mBIndex,22)*8+1;
y_FrameCr=floor(mBIndex/22)*8+1;
x_FrameCb=mod(mBIndex,22)*8+1;
y_FrameCb=floor(mBIndex/22)*8+1;

maxd=7; % megisti apostasi anazitisis

mV=[0, 0;0,0];%initialize

mBY=frameY(y_FrameY:(y_FrameY+15),x_FrameY:(x_FrameY+15));  %reference macroblock
mBCr=frameCr(y_FrameCr:(y_FrameCr+7),x_FrameCr:(x_FrameCr+7));
mBCb=frameCb(y_FrameCb:(y_FrameCb+7),x_FrameCb:(x_FrameCb+7));

mBCb1 = double(mBCb);
mBCr1 = double(mBCr);
mBY1 = double(mBY);

best_err_backw=16*16*256;
best_err_forw=16*16*256;
for y=-maxd:maxd
for x =-maxd : maxd
   if y_FrameY+y>0 && y_FrameY+y+15<289 && x_FrameY+x>0 && x_FrameY+x+15<353 %for not exeeding image size
    backwmBY=backwFrameY(y_FrameY+y:(y_FrameY+15)+y,x_FrameY+x:(x_FrameY+15)+x);
    forwmBY=forwFrameY(y_FrameY+y:(y_FrameY+15)+y,x_FrameY+x:(x_FrameY+15)+x);

    backwmBCr=backwFrameCr(y_FrameCr:(y_FrameCr+7),x_FrameCr:(x_FrameCr+7));
    backwmBCb=backwFrameCb(y_FrameCb:(y_FrameCb+7),x_FrameCb:(x_FrameCb+7));
    
    forwmBCr=forwFrameCr(y_FrameCr:(y_FrameCr+7),x_FrameCr:(x_FrameCr+7));
    forwmBCb=forwFrameCb(y_FrameCb:(y_FrameCb+7),x_FrameCb:(x_FrameCb+7));
    
    backwmBY1 = double(backwmBY); % converting to double to substract properly     
    forwmBY1 = double(forwmBY);
    
    erMBYbackw=backwmBY1-mBY1;
    erMBYforw=forwmBY1-mBY1;
    
    errYbackw=abs(erMBYbackw);
    tot_temp_err_backw=sum(sum(errYbackw));
    errYforw=abs(erMBYforw);
    tot_temp_err_forw=sum(sum(errYforw));
    
    
    if tot_temp_err_backw< best_err_backw
        best_err_backw=tot_temp_err_backw;
        mV(1,1)=x;
        mV(2,1)=y;
        best_mBY_backw=double(backwmBY);
        best_mBCb_backw=double(backwmBCb);
        best_mBCr_backw=double(backwmBCr);
        best_eMBY_backw=erMBYbackw;
     end
    
    if tot_temp_err_forw< best_err_forw
        best_err_forw=tot_temp_err_forw;
        mV(1,2)=x;
        mV(2,2)=y;
        best_mBY_forw=double(forwmBY);
        best_mBCb_forw=double(forwmBCb);
        best_mBCr_forw=double(forwmBCr);
        best_eMBY_forw=erMBYforw;

    end    
      
    
    
   end
   
   
   
end
end

eMBY=(0.5)*(best_mBY_backw+best_mBY_forw)-mBY1;
eMBCb=(0.5)*(best_mBCb_backw+best_mBCb_forw)-mBCb1;
eMBCr=(0.5)*(best_mBCr_backw+best_mBCr_forw)-mBCr1;


% figure;

x=uint8(mBY1);

y=uint8(best_mBY_forw);

z=uint8(best_mBY_backw);


% subplot(3,1,1);
% imshow(x);
% subplot(3,1,2);
% imshow(y);
% subplot(3,1,3);
% imshow(z);


end

