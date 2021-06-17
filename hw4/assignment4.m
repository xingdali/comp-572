% Part1 basic method
I = imread("forest.jpg");
height = size(I, 1);
width = size(I, 2);
% divide the height to 3 equal parts
h = floor(height / 3);
first = im2double(imcrop(I, [0, 0, width, h]));
second = im2double(imcrop(I, [0, h+1, width, h-1]));
third = im2double(imcrop(I, [0, 2*h+1, width, h-1]));
original = cat(3, first, second, third);
% apply ncc to first two images
corr = normxcorr2(first, second);
[ypeak,xpeak] = find(corr==max(corr(:)));
yoffSet = ypeak-size(first,1);
xoffSet = xpeak-size(first,2);

% align the first image
first = imtranslate(first, [xoffSet, yoffSet]);
% apply ncc to the second and third images
corr = normxcorr2(third, second);
[ypeak,xpeak] = find(corr==max(corr(:)));
yoffSet = ypeak-size(third,1);
xoffSet = xpeak-size(third,2);
% align the third image to the second image
third = imtranslate(third, [xoffSet, yoffSet]);
% combine the three channels
I = [];
I(:,:,1) = first;
I(:,:,2) = second;
I(:,:,3) = third;
figure(1);imshow(I)
figure(2);imshow(original)


% Part2 enhancements
I = im2double(imread("forest.jpg"));
height = size(I, 1);
width = size(I, 2);
% divide the height to 3 equal parts
h = floor(height / 3);
first = im2double(imcrop(I, [0, 0, width, h]));
second = im2double(imcrop(I, [0, h+1, width, h-1]));
third = im2double(imcrop(I, [0, 2*h+1, width, h-1]));

% I will try to split the image to 9 equal parts and align the central part
% to reduce borders' affect

% cut the central parts of the three images
cheight = size(first, 1);
cwidth = size(first, 2);
center_first = imcrop(first, [floor(cwidth/3)+1, floor(cheight/3)+1, floor(cwidth/3)+1, floor(cheight/3)+1]);
center_second = imcrop(second, [floor(cwidth/3)+1, floor(cheight/3)+1, floor(cwidth/3)+1, floor(cheight/3)+1]);
center_third = imcrop(third, [floor(cwidth/3)+1, floor(cheight/3)+1, floor(cwidth/3)+1, floor(cheight/3)+1]);

% use ncc to align them same as part 1
maximum = 0;
angle = 0;
for temp_angle = 1.0:-0.1:-1.0
    temp_first = imrotate(center_first, temp_angle, 'crop');
    temp_corr = normxcorr2(temp_first, center_second);
    temp = max(temp_corr(:));
    if temp > maximum
        angle = temp_angle;
        corr = temp_corr;
        maximum = temp;
    end 
end 
[ypeak,xpeak] = find(corr==max(corr(:)));
center_first = imrotate(center_first, angle, 'crop');
yoffSet = ypeak-size(center_first,1);
xoffSet = xpeak-size(center_first,2);
% align the first image
first = imrotate(first, angle, 'crop');
first = imtranslate(first, [xoffSet, yoffSet]);
% apply ncc to the second and third images
maximum = 0;
for temp_angle = 1.0:-0.1:-1.0
    temp_third = imrotate(center_third, temp_angle, 'crop');
    temp_corr = normxcorr2(temp_third, center_second);
    temp = max(temp_corr(:));
    if temp > maximum
        angle = temp_angle;
        corr = temp_corr;
        maximum = temp;
    end 
end
[ypeak,xpeak] = find(corr==max(corr(:)));
center_third = imrotate(center_third, angle, 'crop');
yoffSet = ypeak-size(center_third,1);
xoffSet = xpeak-size(center_third,2);
% align the third image to the second image
third = imrotate(third, angle, 'crop');
third = imtranslate(third, [xoffSet, yoffSet]);

I = [];
I(:,:,1) = first;
I(:,:,2) = second;
I(:,:,3) = third;
figure(2);imshow(I)