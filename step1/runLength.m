function [runSymbols] = runLength(qBlock)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
l=size(qBlock);
t=0;
zero_counter=0; %  counter of zeros :D
sum=l(1)*l(2);  %calculating entries
symbol=0;% symbol counter
%--------------zig-zag scan implementation-------
for d=2:sum
    c=rem(d,2);  % even or odd
    for i=1:l(1)
        for j=1:l(2)
            if((i+j)==d)
                t=t+1;
                if(c==0)
                    next_element=qBlock(j,d-j);
                else
                    next_element=qBlock(d-j,j);
                end
                %-----------Katagrafi mikon diadromis
                if next_element==0
                    zero_counter=zero_counter+1;
                else
                    symbol=symbol+1;
                    runSymbols( symbol,1)=zero_counter;
                    runSymbols( symbol,2)=next_element;
                    zero_counter=0;
                end
                %-------------------end of katagrafis------------------
            end
            
        end
        %
    end
end


end

