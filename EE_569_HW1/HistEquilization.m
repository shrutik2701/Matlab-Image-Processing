% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 28 Jan, 2024

clear all;
close all;

% Read the image
img = (readraw( "DimLight.raw" , 340,596,1));
figure;
imshow(uint8(img));
title("Original image");

equalized_img = Trans_func_hist_eq(img);
writeraw(equalized_img,"HistEq_Method_A.raw",1);
figure;
imshow(uint8(equalized_img));
title("After Method A");

% METHOD -2 
buc_eq_img = Bucket_fill_hist_eq(uint8(img));
writeraw(buc_eq_img,"HistEq_Method_B.raw",1);
figure;
imshow(uint8(buc_eq_img));
title("After Method B");
