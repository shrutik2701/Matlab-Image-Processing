% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 28 Jan, 2024

clear all; close all;
% Read image
img = (readraw( "City.raw" ,422, 750,0));
imshow(uint8(img));
title("Original image");

% Creating YUV image
img_yuv = zeros(422,750,3);
y = zeros(422,750);
for i=1:422
    for j=1:750
        img_yuv(i,j,1) =  (0.257 * img(i,j,1)) + (0.504 * img(i,j,2)) + (0.098 * img(i,j,3)) + 16;
        img_yuv(i,j,2) = -(0.148 * img(i,j,1)) - (0.291 * img(i,j,2)) + (0.439 * img(i,j,3)) + 128;
        img_yuv(i,j,3) =  (0.439 * img(i,j,1)) - (0.368 * img(i,j,2)) - (0.071 * img(i,j,3)) + 128;
        y(i,j) = floor(img_yuv(i,j,1));
    end
end

% ALL THREE METHODS

% Method A
y1 = Trans_func_hist_eq(y);

% Method - B
buc_eq_img = Bucket_fill_hist_eq(y);

% Method C
y3 = adapthisteq(uint8(y),'clipLimit',0.01,'Distribution','rayleigh');

% Modified RGB
img_rgb = zeros(422,750,3);
img_rgb_b = zeros(422,750,3);
img_rgb_c = zeros(422,750,3);
for i=1:422
    for j=1:750
        img_rgb(i,j,1) = 1.164*(y1(i,j) - 16) + 1.596*(img_yuv(i,j,3) - 128);
        img_rgb_b(i,j,1) = 1.164*(buc_eq_img(i,j) - 16) + 1.596*(img_yuv(i,j,3) - 128);
        img_rgb_c(i,j,1) = 1.164*(y3(i,j) - 16) + 1.596*(img_yuv(i,j,3) - 128);
        img_rgb(i,j,2) = 1.164*(y1(i,j) - 16) - 0.813*(img_yuv(i,j,3) - 128) - 0.391*(img_yuv(i,j,2) - 128);
        img_rgb_b(i,j,2) = 1.164*(buc_eq_img(i,j) - 16) - 0.813*(img_yuv(i,j,3) - 128) - 0.391*(img_yuv(i,j,2) - 128);
        img_rgb_c(i,j,2) = 1.164*(y3(i,j) - 16) - 0.813*(img_yuv(i,j,3) - 128) - 0.391*(img_yuv(i,j,2) - 128);
        img_rgb(i,j,3) =  1.164*(y1(i,j) - 16) + 2.018*(img_yuv(i,j,2) - 128);
        img_rgb_b(i,j,3) =  1.164*(buc_eq_img(i,j) - 16) + 2.018*(img_yuv(i,j,2) - 128);
        img_rgb_c(i,j,3) =  1.164*(y3(i,j) - 16) + 2.018*(img_yuv(i,j,2) - 128);
    end
end


figure;
%subplot(2,2,1);
imshow(uint8(img_rgb));
title("Haze removed - method A");
writeraw(img_rgb,"Haze_removed_Method_A.raw",0);
figure;
%subplot(2,2,2);
imshow(uint8(img_rgb_b));
title("Haze removed - method B");
writeraw(img_rgb_b,"Haze_removed_Method_B.raw",0);
%subplot(2,2,3);
figure;
imshow(uint8(img_rgb_c));
title("Haze removed - method C");
writeraw(img_rgb_c,"Haze_removed_CLAHE.raw",0);
% subplot(2,2,4);
figure;
imshow(uint8(img));
title("original ")
