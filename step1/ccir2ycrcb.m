function [frameY, frameCr, frameCb] = ccir2ycrcb(frameRGB)
%% Summary of this function goes here
% Converting RGB to YCbCr(ITU-R BT.601)
% SubSample to 4:2:0

%% Conversion
% http://www.equasys.de/colorconversion.html
% http://www.compression.ru/download/articles/color_space/ch03.pdf
% Transform Matrices
rgbycbcr = [0.257 0.504 0.098;
            -0.148 -0.291 0.439;
            0.439 -0.368 -0.071];

cons=[16 128 128]';

% Image Sizes column*rows*d
[c, r ,d] = size( frameRGB );

% Reshape for matrix multi
temp = reshape(frameRGB , c*r , 3 );

% Conversion
temp = rgbycbcr * double(temp');
% Add a column vector to Matrix's Columns
temp = bsxfun(@plus, temp, cons);

% Reshape back to original
YCBCR = uint8( min( max( reshape(temp',[c r d]),0 ),255 ));
% Display
% figure
% imshow(YCBCR)

%% SubSample 4:2:0

% Y, Cb & CR , Fir Filter

u = [-29 0 88 138 88 0 -29] / 256;    %fir filter for Y
v = [1 3 3 1] / 8;                     %fir filter for CB CR

% Y SubSampling
%--------------

temp = double( YCBCR(:,:,1) );
temp = temp(1:2:end,: );      % Odd field only

% Apply filter horizontally
x = filter( u,1,temp,[],2 );
x = x(:,1:2:end);

frameY = double(x);

% Cb,Cr SubSampling
%------------------
cb = double( YCBCR(:,:,2) );
cr = double( YCBCR(:,:,3) );

% Cb
temp = cb( 1:2:end,1:2:end ); % Odd field , odd columns

% Apply filter horizontally and subsample
temp = filter(v,1,temp,[],2);
temp = temp(:,1:2:end);
% Apply filter vertically and subsample
temp = filter (v,1,temp,[],1);
temp = temp(1:2:end,:);

frameCb=double(temp);

% Cr
temp = cr( 1:2:end,1:2:end ); % Odd field , odd columns

% Apply filter horizontally and subsample
temp = filter(v,1,temp,[],2);
temp = temp(:,1:2:end);
% Apply filter vertically and subsample
temp = filter (v,1,temp,[],1);
temp = temp(1:2:end,:);

frameCr=double(temp);


frameY=uint8(frameY(:,1+4:1:end-4));   %Deleting 4 side-left & 4 side-right columns
frameCr=uint8(frameCr(:,1+2:end-2));   %Deleting 2 side-left & 2 side-right columns
frameCb=uint8(frameCb(:,1+2:end-2));   %Deleting 2 side-left & 2 side-right columns
end

