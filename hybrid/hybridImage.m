function [im12] = hybridImage(im1,im2, cutoff_low, cutoff_high)
%HYBRIDIMAGE Summary of this function goes here
%   Detailed explanation goes here
im1_low = imgaussfilt(im1, cutoff_low);
im2_high = im2 - imgaussfilt(im2, cutoff_high);
im12 = im2_high * 0.5 + im1_low * 0.5;
end

