rgb=imread('coastguard000.tiff');
[y,cr,cb]= ccir2ycrcb(rgb);

figure

subplot(1,3,1)
imshow(y)
title('Y component')

subplot(1,3,2)
imshow(cb)
title('Cb component')

subplot(1,3,3)
imshow(cr)
title('Cr component')

figure
subplot(3,1,1)
imshow(rgb)
title('RGB original')

ccir=ycrcb2ccir(y,cr,cb);
subplot(3,1,2)
imshow(ccir)
title('Recontrsucted RGB image')

subplot(3,1,3)
imshowpair(ccir,rgb,'diff');
title('Differnce')