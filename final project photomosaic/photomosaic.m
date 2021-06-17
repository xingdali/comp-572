tic;
img = im2double(imread('myself.jpg'));
% split the 3 color channels
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);
% size of the target image
[height, width] = size(img);
width = width/3;
% height and width for each background images are 20 * 40
pheight = 20;
pwidth = 40;
h = floor(height/pheight)*pheight;
w = floor(width/pwidth)*pwidth;
% create 3 zero channels for the final output
r_f = zeros(h, w);
g_f = zeros(h, w);
b_f = zeros(h, w);
% read all of the bg images
file_path =  './bg/'; 
bg_path_list = dir(strcat(file_path,'*.jpg')); % select all jpg
bg_num = length(bg_path_list);% number of the images
%create 3 channels and combine all of the bg images into a single image
bg_r = [pheight, pwidth*bg_num];
bg_g = [pheight, pwidth*bg_num];
bg_b = [pheight, pwidth*bg_num];
% a matrix to store the average of each channel of each bg image
average = [3, bg_num];
for i=1: bg_num
    % find each background image's name
    image_name = bg_path_list(i).name;
    image = im2double(imread(strcat(file_path,image_name)));
    image_resize = imresize(image,[pheight,pwidth]);
    [hh, ww] = size(image_resize);
    % if the image is black and white, ww is 40. filter those images
    if ww == 40
        continue;
    end
    % put each image's rgb to the bg matrix
    bg_r(1:pheight, (i*pwidth+1-pwidth):i*pwidth) = image_resize(:,:,1);
    bg_g(1:pheight, (i*pwidth-pwidth+1):i*pwidth) = image_resize(:,:,2);
    bg_b(1:pheight, (i*pwidth+1-pwidth):i*pwidth) = image_resize(:,:,3);
    % store each image's average
    average(1,i) = mean(mean(image_resize(:,:,1)));
    average(2,i) = mean(mean(image_resize(:,:,2)));
    average(3,i) = mean(mean(image_resize(:,:,3)));
end

for x=1:pheight:h
    for y=1:pwidth:w
        % calculate the average rgb of 20*40 pixels area in target image
        ave_r = mean(mean(r(x:x+pheight-1, y:y+pwidth-1)));
        ave_g = mean(mean(g(x:x+pheight-1, y:y+pwidth-1)));
        ave_b = mean(mean(b(x:x+pheight-1, y:y+pwidth-1)));
        
        % find the 5 best match
        min_list = [0,0,0,0,0,0,0,0,0,0];
        min_indices = [1,2,3,4,5,6,7,8,9,10];
        for i=1:10
            min_list(i) = (average(1,i)-ave_r)^2 + (average(2,i)-ave_g)^2 + (average(3,i)-ave_b)^2;
        end
        for i=11:bg_num
            temp = (average(1,i)-ave_r)^2 + (average(2,i)-ave_g)^2 + (average(3,i)-ave_b)^2;
            % if the temp value is smaller than the maximum value in
            % the min_list, swap the two value and record the index
            max_i = find(min_list == max(min_list(:)));
            if temp < min_list(max_i)
                min_list(max_i) = temp;
                min_indices(max_i) = i;
            end
        end
        % randomly choose a image from one of the best matches and blend
        % with the target object
        image_index = min_indices(randi(10));
        r_f(x:x+pheight-1, y:y+pwidth-1) = r(x:x+pheight-1, y:y+pwidth-1) * 0.1 + bg_r(1:pheight, (image_index-1)*pwidth+1:image_index*pwidth) * 0.9;
        g_f(x:x+pheight-1, y:y+pwidth-1) = g(x:x+pheight-1, y:y+pwidth-1) * 0.1 + bg_g(1:pheight, (image_index-1)*pwidth+1:image_index*pwidth) * 0.9;
        b_f(x:x+pheight-1, y:y+pwidth-1) = b(x:x+pheight-1, y:y+pwidth-1) * 0.1 + bg_b(1:pheight, (image_index-1)*pwidth+1:image_index*pwidth) * 0.9;
    end
end
output = cat(3,r_f,g_f,b_f);
figure(2);imshow(output);
toc