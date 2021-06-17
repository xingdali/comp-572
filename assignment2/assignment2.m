% Exercise 1
% 1.
figure
I = imread('venice1.jpg');
I = im2double(I);
subplot(2,1,1)
imshow(I)
I_gray = rgb2gray(I);
subplot(2,1,2)
imshow(I_gray)
    %my own image
    figure
    game = imread('game.jpg');
    game = im2double(game);
    subplot(2,1,1)
    imshow(game)
    game_gray = rgb2gray(game);
    subplot(2,1,2)
    imshow(game_gray)

%2.
I = imread('venice1.jpg');
I = im2double(I);
I_red = I(:,:,1);
I_green = I(:,:,2);
I_blue = I(:,:,3);
imshow((I_red + I_green + I_blue) / 3)
    %my own image
    game = imread('game.jpg');
    game = im2double(game);
    game_red = game(:,:,1);
    game_green = game(:,:,2);
    game_blue = game(:,:,3);
    imshow((game_red + game_green + game_blue) / 3)
    
%3.
I = imread('venice1.jpg');
I = im2double(I);
I_red = I(:,:,1);
I_green = I(:,:,2);
I_blue = I(:,:,3);
imshow(I_red * 0.30 + I_green * 0.59 + I_blue * 0.11);
    %my own image
    game = imread('game.jpg');
    game = im2double(game);
    game_red = game(:,:,1);
    game_green = game(:,:,2);
    game_blue = game(:,:,3);
    imshow(game_red * 0.30 + game_green * 0.59 + game_blue * 0.11);

    
%4.
I = imread('venice1.jpg');
I = im2double(I);
I_hsv = rgb2hsv(I);
I_hsv(:,:,2) = 0;
imshow(hsv2rgb(I_hsv))
    %my own image
    game = imread('game.jpg');
    game = im2double(game);
    game_hsv = rgb2hsv(game);
    game_hsv(:,:,2) = 0;
    imshow(hsv2rgb(game_hsv))

% I personally like the third method the most. The second just got the
% average of the three colors which lost a lot of details in the picture
% and the fourth one lost some details in pixels that are too bright or
% dark. The third one is perfect to me since it just remove the colors and
% the brightness of everything is suitable for human eyes to perceive all
% of the details.


%Exercise 2
I = imread('venice1.jpg');
I = im2double(I);
I_red = I(:,:,1);
I_green = I(:,:,2);
I_blue = I(:,:,3);
sepia_r = I_red * 0.393 + I_green * 0.769 + I_blue * 0.189;
sepia_g = I_red * 0.349 + I_green * 0.686 + I_blue * 0.168;
sepia_b = I_red * 0.272 + I_green * 0.534 + I_blue * 0.131;
sepia(:,:,1) = sepia_r;
sepia(:,:,2) = sepia_g;
sepia(:,:,3) = sepia_b;
imshow(sepia)
    %my own picture
    game = imread('game.jpg');
    game = im2double(game);
    game_red = game(:,:,1);
    game_green = game(:,:,2);
    game_blue = game(:,:,3);
    sepia_r = game_red * 0.393 + game_green * 0.769 + game_blue * 0.189;
    sepia_g = game_red * 0.349 + game_green * 0.686 + game_blue * 0.168;
    sepia_b = game_red * 0.272 + game_green * 0.534 + game_blue * 0.131;
    sepia_game(:,:,1) = sepia_r;
    sepia_game(:,:,2) = sepia_g;
    sepia_game(:,:,3) = sepia_b;
    imshow(sepia_game)
    
    %the result is really nice
    
%Exercise 3
I = imread('venice2.jpg');
I = im2double(I);
I_red = I(:,:,1);
I_green = I(:,:,2);
I_blue = I(:,:,3);
mean_red = mean2(I_red);
mean_green = mean2(I_green);
mean_blue = mean2(I_blue);
overall_avg = (mean_red + mean_green + mean_blue) / 3;
new_red = I_red * overall_avg / mean_red;
new_green = I_green * overall_avg / mean_green;
new_blue = I_blue * overall_avg / mean_blue;
new_I(:,:,1) = new_red;
new_I(:,:,2) = new_green;
new_I(:,:,3) = new_blue;
imshow(new_I)

%my image
I = imread('game.jpg');
I = im2double(I);
I_red = I(:,:,1);
I_green = I(:,:,2);
I_blue = I(:,:,3);
mean_red = mean2(I_red);
mean_green = mean2(I_green);
mean_blue = mean2(I_blue);
overall_avg = (mean_red + mean_green + mean_blue) / 3;
new_red = I_red * overall_avg / mean_red;
new_green = I_green * overall_avg / mean_green;
new_blue = I_blue * overall_avg / mean_blue;
new_I(:,:,1) = new_red;
new_I(:,:,2) = new_green;
new_I(:,:,3) = new_blue;
imshow(new_I)

%exercise4
    %1.
    I = imread('venice3.jpg');
    I = im2double(I);
    figure
    subplot(2,1,1)
    imshow(I)
    subplot(2,1,2)
    imhist(I)        %threshold 0.15-0.5
    I_hsv = rgb2hsv(I);
    I_value = I_hsv(:,:,3);
    I_value2 = imadjust(I_value,[0.15 0.5],[0 1]);
    I_hsv(:,:,3) = I_value2;
    I = hsv2rgb(I_hsv);
    subplot(2,1,1)
    imshow(I)
        %my image
        I = imread('game2.jpg');
        I = im2double(I);
        figure
        subplot(2,1,1)
        imshow(I)
        subplot(2,1,2)
        imhist(I)        %threshold 0.1-0.7
        I_hsv = rgb2hsv(I);
        I_value = I_hsv(:,:,3);
        I_value2 = imadjust(I_value,[0.1 0.7],[0 1]);
        I_hsv(:,:,3) = I_value2;
        I = hsv2rgb(I_hsv);
        subplot(2,1,1)
        imshow(I)
        
        %the venice picture received a great enhancement by this method and
        % everything looks great. I lowered the contrast of my picture by using the built-in
        % camera app in my cellphone and applied the technique 1. The
        % effect is kind of weird especially for the floor of the court,
        % the colors seemed over saturated.
        
    %2. 
    I = imread('venice3.jpg');
    figure
    subplot(2,1,1)
    imshow(histeq(im2double(I)));
    subplot(2,1,2)
    imhist(histeq(im2double(I)));
        %my image
        I = imread('game2.jpg');
        figure
        subplot(2,1,1)
        imshow(histeq(im2double(I)));
        subplot(2,1,2)
        imhist(histeq(im2double(I)));
        
        %The darker parts were improved a lot, but for the floor of the
        %court this method produced the same issue






 
   %exercise5
           % first filter
           I = im2double(imread('car.jpg'));
           %color balancing by using exercise 3
           I_red = I(:,:,1);
           I_green = I(:,:,2);
           I_blue = I(:,:,3);
           mean_red = mean2(I_red);
           mean_green = mean2(I_green);
           mean_blue = mean2(I_blue);
           overall_avg = (mean_red + mean_green + mean_blue) / 3;
           new_red = I_red * overall_avg / mean_red;
           new_green = I_green * overall_avg / mean_green;
           new_blue = I_blue * overall_avg / mean_blue;
           new_red = new_red * 1.3;       % add both red and green to get yellowish warmer style.
           new_green = new_green * 1.2;
           I(:,:,1) = new_red;
           I(:,:,2) = new_green;
           I(:,:,3) = new_blue;
           I_hsv = rgb2hsv(I);
           % reduce saturation to add some fading effect
           I_saturation = I_hsv(:,:,2);
           I_hsv(:,:,2) = I_saturation * 0.95 - 0.05;
           %back to rgb
           I = hsv2rgb(I_hsv);
           % add vignetting effect
           h = fspecial('gaussian', [1080 1492], 600);
           h = h / h(540, 746); %normalize
           I = I .* h;
           imshow(I)
   
    
            % second filter
            I = im2double(imread('game.jpg'));
            %color balancing
           I_red = I(:,:,1);
           I_green = I(:,:,2);
           I_blue = I(:,:,3);
           mean_red = mean2(I_red);
           mean_green = mean2(I_green);
           mean_blue = mean2(I_blue);
           overall_avg = (mean_red + mean_green + mean_blue) / 3;
           new_red = I_red * overall_avg / mean_red;
           new_green = I_green * overall_avg / mean_green;
           new_blue = I_blue * overall_avg / mean_blue;
           new_blue = new_blue * 1.1; % add a little blueish to the image to make real carolina blue
           new_red = new_red * 1.03; % a little reddish.
           I(:,:,1) = new_red;
           I(:,:,2) = new_green;
           I(:,:,3) = new_blue;
           % add contrast
           I_hsv = rgb2hsv(I);
           I_value = I_hsv(:,:,3);
           I_value = imadjust(I_value, [0.18 0.82], [0 1]);
           I_hsv(:,:,3) = I_value;
           % reduce saturation to add some fading effect
           I_saturation = I_hsv(:,:,2);
           I_hsv(:,:,2) = I_saturation * 0.95 - 0.05;
           %back to rgb
           I = hsv2rgb(I_hsv);
           imshow(I)
           
