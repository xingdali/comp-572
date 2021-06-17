function pyr_L = pyr_laplacian(im, levels)
    pyr_G = pyr_gaussian(im, levels);               % first compute the Gaussian pyramid

    % add code here to compute the Laplacian pyramid from the Gaussian pyramid
    % Tip:  the highest level of the Laplacian pyramid is the same as the Gaussian level.
    % Every lower level of the Laplacian pyramid is the difference between 
    %   the Gaussian at that level minus the Gaussian at the next higher level.
    pyr_L = zeros([levels, size(im)]);
    pyr_L(levels, :, :, :, :) = pyr_G(levels, :, :, :, :);
    for i = 1 : (levels - 1)
        pyr_L(i, :, :, :, :) = pyr_G(i, :, :, :, :) - pyr_G((i + 1), :, :, :, :);
    end
end
