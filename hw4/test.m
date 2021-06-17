% Credit:  Alex Berg

% make a debugging image

% first make a color image with a white square in the middle and a
% black border

I = zeros(110,110,3,'uint8');
I(6:104,6:104,:)=75;
I(50:61,50:61,:)=255;

imagesc(I); axis image; % show the image

% now make the triple image with some offsets so that it will not lineup
rI = zeros(330,110,'uint8');
rI(1:110,1:110)=I(:,:,1);
rI(112:220,1:109)=I(1:end-1,2:110,2);
rI(221:328,1:110)=I(3:end,:,3);

imagesc(rI); axis image; colormap gray; % show the triple


% show that simply placing the layers on top of eachother shows
% problems on the borders.
imagesc(cat(3,rI(1:110,:),rI(111:220,:),rI(221:330,:)));
axis image;

%write the image
imwrite(rI,'sample1.jpg','quality',100);
