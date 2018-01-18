function [pic, picType, tempRef] = getNextPicture(bName, fExtension, frameNumber, ...
startFrame, GoP)
%frameNumber= trexon thesi sto GoP (integer)
%startFrame=  arxi tou gop(integer)

sizeofGop=size(GoP,2);

if frameNumber==startFrame
    picType='I';
    picture_name=sprintf('%s%03d.%s', bName,startFrame,fExtension);
    tempRef=1;
else
   [sort] = sortGoP(GoP);% sorting function according to the priority of encoding
    tempRef=frameNumber-startFrame+1;%finding current tempRef
    Current_Index=find(sort==tempRef);%find current frame in sort list
    tempRef=sort(Current_Index+1);%find next frame to be encoded
    picType=GoP(tempRef);
    picture_name=sprintf('%s%03d.%s',bName,(startFrame+tempRef-1),fExtension);
end




pics = imread(picture_name);
[pic.frameY, pic.frameCr, pic.frameCb] = ccir2ycrcb(pics);

%decPic.frameY, decPic.frameCr, decPic.frameCb


end


function [sort] = sortGoP(GoP)
%sorting GoP regarding priority of encoding
sizeofGop=size(GoP,2);
sort(1)=1;
GoP(1)=0;
pre=1;
post=1;
for i=2:(sizeofGop-1)
    for j=2:sizeofGop
        switch GoP(j)
            case 'I'
                sort(i)=j;
                if post<j
                    post=j;
                end
                GoP(j)=0;
                break;
            case 'P'
                sort(i)=j;
                if post<j
                    post=j;
                end
                GoP(j)=0;
                break;
            case 'B'
                if pre<j && post>j
                    sort(i)=j;
                    GoP(j)=0;
                    if post<j
                        post=j;
                    end
                    break;
                end
                
%             otherwise
%                 a=1+1;
        end
        
    end
    
end
sort(sizeofGop) = find(GoP);
%---------------
end
