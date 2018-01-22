function [vlcStream] = vlc(runSymbols)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

global d15a;
global d15b;
global d16a;
global d16b;
global d17a;
global d17b;

getTheGlobals
elements=size(runSymbols);
elements=elements(1); %number of run symbols to be encoded

vlcStream = cell(elements,1);
for i=1:elements
    
    
    I = find( d15a(:,1) == runSymbols(i,1) );  %vrisko oles ta index ton run length
    m = d15a(I,:);
    if not( isempty(I) )
        D = find( m(:,2) == abs( runSymbols(i,2) ) );% abs dioti o d15a exei mono thetika
        bingo = I(D);%i thesi ton stixion sto d15a
        final = d15b(bingo); % afou 3ero ti thesi 3ero ke to string apo d15b
        final = strcat( final, num2str( runSymbols(i,2) < 0) ); %prostheto telefteo psifio gia thetika arnitika simfona me protipo
    end
    
    if isempty( bingo ) % if not in the main tables use d16 & d17
%         first_part = '000001';
        first_part = d16b(runSymbols(i,1)+1);
        S = find(d17a ==runSymbols(i,2));
        second_part = d17b(S);
        final = strcat(first_part , second_part);
    end
    
    I(:) = [];    %emptying matrices due to isemptychecks
    D(:) = [];
    
    vlcStream{i}=final;
    
    
end

runSymbols;
vlcStream{elements+1}={'10'}; %EOB
end

