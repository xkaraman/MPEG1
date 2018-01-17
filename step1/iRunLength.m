function [qBlock] = iRunLength(runSymbols)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
qBlock=zeros(8,8);
l=size(qBlock);
t=0;
elements=size(runSymbols);
elements=elements(1); %number of run symbols to be written
element_index=1; %deiktis eggrafis
skips=runSymbols(1,1); %number of times skipping the zig zag writing
runSymbols(elements+1,1)=0;
sum=l(1)*l(2);  %calculating entries
symbol=0;% symbol counter
%--------------zig-zag scan implementation-------
for d=2:sum
    c=rem(d,2);  % even or odd
    for i=1:l(1)
        for j=1:l(2)
            if((i+j)==d)
                t=t+1;
                
                %-----------eggrafi ston pinaka mi midenikon timon
                if element_index<=elements %if inside matrix
                    if skips==0
                        element_index=element_index+1;
                        skips=runSymbols(element_index,1);
                        
                        if(c==0)
                            qBlock(j,d-j)=runSymbols(element_index-1,2);
                        else
                            qBlock(d-j,j)=runSymbols(element_index-1,2);
                        end
                        
                    else
                        skips=skips-1;  % osa ine ta midenika pou paremvalonte, toses fores tha ginei skip i eggrafi
                    end
                end
                %-------------------end of eggrafis------------------
            end
            
        end
        %
    end
end

end



