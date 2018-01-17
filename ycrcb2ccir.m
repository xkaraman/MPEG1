function [frameRGB] = ycrcb2ccir(frameY, frameCr, frameCb)
%% Summary of this function goes here
% Converting YCbCr(ITU-R BT.601) to RGB

%% Conversion
% http://www.equasys.de/colorconversion.html
% Transform Matrices
ycbcrrgb = [ 1.164  0.000  1.596;
             1.164  -0.392 -0.813;
             1.164  2.017  0.000 ];


Y = imresize(frameY,[576 720],'bicubic') - 16 ;
Cr = imresize(frameCr,[576 720],'bicubic') - 128 ;
Cb = imresize(frameCb,[576 720],'bicubic') -128 ;

temp1=cat(3,Y,Cb,Cr);

% Image Sizes column*rows*d
[c, r ,d] = size( temp1 );

% Reshape for matrix multi
temp = reshape(temp1 , c*r , 3 );

% Conversion
temp = ycbcrrgb * double(temp');

% Reshape back to original
frameRGB=uint8(reshape(temp',[c r d]));
    
% Display
%figure
imshow(frameRGB);

end

