function pyr_G = pyr_gaussian(im, levels)
    pyr_G = zeros([levels, size(im)]);      % result is array of images of dimensionality: levels X image dimensions
                                            % i.e., pyr_G has dimensions:  levels X rows X cols X colors
    pyr_G(1, :, :, :) = im(:, :, :);        % level 1 is the orignal image
    for i=2:levels
        pyr_G(i, :, :, :) = imgaussfilt(im, 2^(i-1));   % level 2 is image filtered with Gaussian(2)
    end                                                 % level i is image filtered with Gaussian(2^(i-1))
end
