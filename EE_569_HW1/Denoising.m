% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 28 Jan, 2024

% 2 (a)-(d)

clear all; close all;
% Read image
org = (readraw( "Flower_gray_noisy.raw" ,512, 768,1));
figure;
imshow(uint8(org));
title("original");

sigma_c = 2;
sigma_s = 16;
sigma = 0.7;
filter_size = 5;

[psnr_bil,y_bil]= Bilt_filt(org, filter_size, sigma_c, sigma_s);
[psnr_gau,y_gau]= gauss_filt(org,filter_size,sigma);
[psnr_u,y_u]= uni_filt(org,filter_size);

nlm = imnlmfilt(org,"DegreeOfSmoothing",10);

figure;
imshow(uint8(y_bil));
title("Bilateral filtered");
figure;
imshow(uint8(y_gau));
title("Gaussian filtered");
figure;
imshow(uint8(y_u));
title("Uniform Filtered");
figure;
imshow(uint8(nlm));
title("NLM Filtered");
