% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 28 Jan, 2024

% Watercolor effect
clear all; close all;
% Read image
img = readraw("Flower_noisy.raw",512,768,0);
figure;
imshow(uint8(img));
title("Original image");

% Median Filtering
filt_size = 5;
Im = median_filt(img, filt_size);


figure;
imshow(uint8(Im));
title("Im");

% Bilateral Filtering
Ib = Im;
bi_filt_size = 5;
sigma_c = 20;
sigma_s = 10;
for k=1:5
    [~,Ib(:,:,1)] = Bilt_filt(Ib(:,:,1),bi_filt_size,sigma_c, sigma_s);
    [~,Ib(:,:,2)] = Bilt_filt(Ib(:,:,2),bi_filt_size,sigma_c, sigma_s);
    [~,Ib(:,:,3)] = Bilt_filt(Ib(:,:,3),bi_filt_size,sigma_c, sigma_s);
end

figure;
imshow(uint8(Ib));
title("Ib");

% Gaussian Filter
Ig = zeros(512,768,3);
[~,Ig(:,:,1)] = gauss_filt(img(:,:,1),7,2);
[~,Ig(:,:,2)] = gauss_filt(img(:,:,2),7,2);
[~,Ig(:,:,3)] = gauss_filt(img(:,:,3),7,2);

figure;
imshow(uint8(Ig));
title("Ig");

% Linear Combination

Iout = 1.4*Ib - 0.4*Ig;

figure;
imshow(uint8(Iout));
title("Water Color Filter Effect");

