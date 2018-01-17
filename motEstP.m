function [eMBY, eMBCr, eMBCb, mV] = motEstP( frameY, frameCr, frameCb, mBIndex, refFrameY, refFrameCr, refFrameCb)
%% Motion Estimation for P-frames
%   Inputs:
%   mbIndex:marcoblock index number
%   refxx: reference Y,Cb,Cr components
%   framexx: frame Y,Cb,Cr componets to find Motion Vectors
%   
%   Outputs:
%   eMBxx: prediction error
%   mV: motion Vectors
%       second column is NaN due to no reference in future frame

% mv=[x, Nan;y,Nan];

%lumasize = 16;
%chromasize = 8;

%% --------- Y-Motion Estimation ----------

% starting pixels
xstartY = mod(mBIndex,22)*16+1;
ystartY = floor(mBIndex/22)*16+1;

xstartCrCb = mod(mBIndex,22)*8+1;
ystartCrCb = floor(mBIndex/22)*8+1;

% megisti apostasi anazitisis
maxd=7;

% Frame macroblock
mBY = frameY( ystartY:(ystartY+15), xstartY:(xstartY+15) );
mBCr = frameCr( ystartCrCb:(ystartCrCb+7), xstartCrCb:(xstartCrCb+7) );
mBCb = frameCb( ystartCrCb:(ystartCrCb+7), xstartCrCb:(xstartCrCb+7) );

mBCb1 = double(mBCb);
mBCr1 = double(mBCr);
mBY1 = double(mBY);

best_err = 16*16*256;


for y=-maxd:maxd
    for x =-maxd : maxd
        % If not exceding image size
        if (ystartY+y>0) && (ystartY+y+15<289) && (xstartY+x>0) && (xstartY+x+15<353) 
            
            refmBY=refFrameY(ystartY+y:(ystartY+15)+y,xstartY+x:(xstartY+15)+x);
            refmBCr=refFrameCr(ystartCrCb:(ystartCrCb+7),xstartCrCb:(xstartCrCb+7));
            refmBCb=refFrameCb(ystartCrCb:(ystartCrCb+7),xstartCrCb:(xstartCrCb+7));
            
            % Converting to double to substract properly
            refmBCb1 = double(refmBCb);
            refmBCr1 = double(refmBCr);
            refmBY1 = double(refmBY); 
            
            erMBY=refmBY1-mBY1;
            erMBCr=refmBCr1-mBCr1;
            erMBCb=refmBCb1-mBCb1;
            
            errY=abs(erMBY);
            errCb=abs(erMBCb);
            errCr=abs(erMBCr);
            
            tot_temp_err=sum(sum(errY))+sum(sum(errCr))+sum(sum(errCb));
            
            if (tot_temp_err < best_err)
                best_err=tot_temp_err;
                mV=[x, NaN;y,NaN];
                eMBCr=erMBCr;
                eMBCb=erMBCb;
                eMBY=erMBY;
            end
        end
    end
end




end

