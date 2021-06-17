% starter script for HW5

    im_bg = im2double(imread('./sample/swim.jpg'));
    im_obj = im2double(imread('./sample/bear.jpg'));
    figure(1);imshow(im_bg);
    figure(2);imshow(im_obj);

    % get source region mask from the user
    objmask = getMask(im_obj);
    figure(3);imshow(objmask);
    % align im_s and mask_s with im_background
    [im_s, mask_s] = alignSource(im_obj, objmask, im_bg, 64);
    
   
    mask_s = im2double(mask_s);

    % Add your code below for blending.
    %   First create the Laplacian pyramid for both the background
    %   and the object (im_s).  Also create a Gaussian pyramid for
    %   the mask.  For these pyramids, skip downsmapling; that is,
    %   maintain the resolution.
    %
    % Do the following 3 tasks:
    %
    %   1.  Simple cut-and-paste.
    
    %   Write your code here for simple cut-and-paste
    
    I = mask_s .* im_s + (1 - mask_s) .* im_bg;
    imshow(I);
    
    
    
    
    
    
    %   2.  Feathering.
    %
    %           Hint:  feather_mask=imgaussfilt(mask_s, sigma);
    %           try different sigmas, where sigma
    %           determines the crossover width
    %
    
    
    %   Write your code here for feathering
    
    feather_mask = imgaussfilt(mask_s, 24);
    f_I = feather_mask .* im_s + (1 - feather_mask) .* im_bg;
    imshow(f_I);
    
    
    
    
    
    
    %   3.  Blending based on Laplacian pyramids.
    %
    %           Hint:  calculate Laplacian pyramid of both images
    %           Calculate the Gaussian pyramid of the mask
    %           Alpha blend the images at each level of the Laplacian
    %           pyramids using the blurred mask at that same level in
    %           its Gaussian pyramid.
    %
    %           For building these pyramids, 6 levels ought to be
    %           sufficient.
    %
    % Comment on the results obtained.
    
    
    % Code for pyr_gaussian is provided.
    % Write your own functions for pyr_laplacian
    levels = 6;
    Gpyramid_mask = pyr_gaussian(mask_s, levels);
    Lpyramid_bg = pyr_laplacian(im_bg, 6);
    Lpyramid_obj = pyr_laplacian(im_s, levels);
    
    % write code here to pyramid blend the two images using the mask
    output = zeros(size(im_bg));
    for i = 1: levels
        output = output + (squeeze(Gpyramid_mask(i, :, :)) .* squeeze(Lpyramid_obj(i, :, :, :)) + (1 - squeeze(Gpyramid_mask(i, :, :))) .* squeeze(Lpyramid_bg(i, :, :, :)));
    end
    imshow(output);