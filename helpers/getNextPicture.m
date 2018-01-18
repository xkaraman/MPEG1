function [ pic, picType, tempRef ] = getNextPicture( bName, fExtension, frameNumber, ...
    startFrame, GoP )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% codeorder = zeros( length(GoP) )

pre = startFrame;
codeorder = startFrame ;

while ( length(codeorder) < length(GoP))
    
    post = nextIP(pre, GoP);
    
    if ( post - pre ) == 1
        codeorder = [codeorder post];
    else
        codeorder = [ codeorder post ];
        for  i = pre+1:post-1
            codeorder = [ codeorder i];
        end
        
    end
    pre=post;
end

find(frameNumber+1 == codeorder )
    pic=codeorder;


end

function [ post ] = nextIP( pre, GoP)

for i=pre+1:length(GoP)
    if ( GoP(i) == 'I' ||  GoP(i) == 'P' )
        post = i;
        return
    end
end
post = pre;
end