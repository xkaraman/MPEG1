clearvars

images=cell(10,1);

for n=1:10
  images{n} = imread(sprintf('../../coastguard-tiffs/coastguard%03d.tiff',n));
end

frameRGB = images{1};
frameRGB1 = images{2};

[fy,fcb,fcr] = ccir2ycrcb(frameRGB);
[refy,refcb,refcr] = ccir2ycrcb(frameRGB1);

[erry,errcr,errcb,mv]=motEstP(fy,fcr,fcb,1,refy,refcr,refcb);

struct