% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 28 Jan, 2024

% Color Image denoising

close all;
% Read image
img = readraw("Flower_noisy.raw",512,768,0);
figure;
imshow(uint8(img));
title("Original noisy image");

figure;
imshow(uint8(img(:,:,1)));
title("Original noisy image - R channel");
% Calculate histogram
histo_r_1 = zeros(1,256);
for i = 1:size(img(:,:,1),1)
    for j = 1:size(img(:,:,1),2)
        histo_r_1(img(i,j,1)+1) = histo_r_1(img(i,j,1)+1) + 1; 
    end
end

figure;
stem(histo_r_1);
xlabel("Pixel intensity");
ylabel("Pixel frequency");
title("R channel noisy image histogram");

figure;
imshow(uint8(img(:,:,2)));
title("Original noisy image - G channel");
% Calculate histogram
histo_g_1 = zeros(1,256);
for i = 1:size(img(:,:,2),1)
    for j = 1:size(img(:,:,2),2)
        histo_g_1(img(i,j,2)+1) = histo_g_1(img(i,j,2)+1) + 1; 
    end
end

figure;
stem(histo_g_1);
xlabel("Pixel intensity");
ylabel("Pixel frequency");
title("G channel noisy image histogram");

figure;
imshow(uint8(img(:,:,3)));
title("Original noisy image - B channel");

% Calculate histogram
histo_b_1 = zeros(1,256);
for i = 1:size(img(:,:,3),1)
    for j = 1:size(img(:,:,3),2)
        histo_b_1(img(i,j,3)+1) = histo_b_1(img(i,j,3)+1) + 1; 
    end
end

figure;
stem(histo_b_1);
xlabel("Pixel intensity");
ylabel("Pixel frequency");
title("B channel noisy image histogram");

filter_size = 3;

Med_op = median_filt(img,filter_size);
figure;
imshow(uint8(Med_op));
title("median filter output");

Bil_op = zeros(size(img));
[~,Bil_op(:,:,1)]=Bilt_filt(img(:,:,1), filter_size, 2, 10);
[~,Bil_op(:,:,2)]=Bilt_filt(img(:,:,2), filter_size, 2, 10);
[~,Bil_op(:,:,3)]=Bilt_filt(img(:,:,3), filter_size, 2, 10);
figure;
imshow(uint8(Bil_op));
title("Bilateral filter output");


Bil_M_op = zeros(size(img));
[~,Bil_M_op(:,:,1)]=Bilt_filt(Med_op(:,:,1), filter_size, 2, 10);
[~,Bil_M_op(:,:,2)]=Bilt_filt(Med_op(:,:,2), filter_size, 2, 10);
[~,Bil_M_op(:,:,3)]=Bilt_filt(Med_op(:,:,3), filter_size, 2, 10);
figure;
imshow(uint8(Bil_M_op));
title("Median+Bilateral filter output");

