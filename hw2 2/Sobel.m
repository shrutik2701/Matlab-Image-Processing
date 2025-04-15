% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 19 Feb 2024

close all;
% Read image
img = readraw("Tiger.raw",321,481,0);
figure;
imshow(uint8(img));
title("Original image");
[x,y,z] = size(img);
% Creating grayscale image
g_img = zeros(size(img,1),size(img,2));
for i=1: size(img,1)
    for j=1:size(img,2)
        g_img(i,j) = 0.2989*img(i,j,1) + 0.5870*img(i,j,2) + 0.1140*img(i,j,3);
    end
end
figure;
imshow(uint8(g_img));
title("Grayscale image");

Gx = 0.25.*[-1, 0, 1; -2, 0, 2; -1, 0, 1];
Gy = 0.25.*[1 2 1; 0 0 0; -1 -2 -1];

% Padding by mirror imaging
padded_g_img = zeropad(g_img,3);

for j=2:y+1
    padded_g_img(1,j) = padded_g_img(2,j);
    padded_g_img(x+2,j) = padded_g_img(x+1,j);
end
for i=2:x+1
    padded_g_img(i,1) = padded_g_img(i,2);
    padded_g_img(i,y+2) = padded_g_img(i,y+1);
end

x_gradient = zeros(size(g_img));
y_gradient = zeros(size(g_img));
f_size = 3;

for i=1+(f_size-1)/2 : size(img,1)+(f_size-1)/2
    for j =1+(f_size-1)/2 : size(img,2)+(f_size-1)/2
        x_gradient(i-(f_size-1)/2, j-(f_size-1)/2) = (conv_img(padded_g_img(i-1:i+1,j-1:j+1), Gx));
        y_gradient(i-(f_size-1)/2, j-(f_size-1)/2) = (conv_img(padded_g_img(i-1:i+1,j-1:j+1), Gy));
    end
end
grad_mag = sqrt(x_gradient.*x_gradient+y_gradient.*y_gradient);

%Normalization
x_min = min(x_gradient(:));
x_max = max(x_gradient(:));
y_min = min(y_gradient(:));
y_max = max(y_gradient(:));
mag_min = min(grad_mag(:));
mag_max = max(grad_mag(:));

[rows,cols,g] = size(grad_mag);

for i = 1: rows
    for j = 1: cols
        x_gradient(i,j) = ((x_gradient(i,j) - x_min)/(x_max - x_min))*255;
        y_gradient(i,j) = ((y_gradient(i,j) - y_min)/(y_max - y_min))*255;
        grad_mag(i,j) = ((grad_mag(i,j) - mag_min)/(mag_max - mag_min))*255;
    end
end


figure;
imshow(uint8(x_gradient));
title("Normalized x-gradient image");
figure;
imshow(uint8(y_gradient));
title("Normalized y-gradient image");
figure;
imshow(uint8(grad_mag));
title("Normalized gradient mag image");

 writeraw(grad_mag, "Sobel_probability_map_tiger.raw" , 1);

% Thresholding

% CDF finding
% Histogram of org image
histo = zeros(1,256);

% Calculate histogram
for i = 1:size(grad_mag,1)
    for j = 1:size(grad_mag,2)
        histo(uint8(grad_mag(i,j))+1) = histo(uint8(grad_mag(i,j))+1) + 1; 
    end
end

% Normalizing histogram ( Calculate probability of each pixel = occurance/totpixels ) & calculating cummulative probab
norm_hist = zeros(1,256);
cumm_prob = zeros(1,256);

for i=1:256
    norm_hist(i) = histo(i)/(size(grad_mag,1)*size(grad_mag,2));         % normalize hist
    if(i~=1)
        cumm_prob(i) = cumm_prob(i-1) + norm_hist(i); % cumulative prob
    else
        cumm_prob(i) = norm_hist(i); % cumulative prob
    end
end

figure;
plot((cumm_prob));
title("CDF of image");
percent = 0.9;
for i=1:256
    if cumm_prob(i)>= percent
        thresh = i;
        break;
    end
end

g_mag_t = zeros(size(grad_mag));
for i=1:size(img,1)
    for j=1:size(img,2)
        if(grad_mag(i,j)< thresh)
            g_mag_t(i,j) = 1;
        else
            g_mag_t(i,j) = 0;
        end
    end
end

figure
imshow((g_mag_t));
title("Thresholded gradient mag image");

 writeraw(g_mag_t, "Sobel_pig_out.raw" , 1);

%Canny edge detector
canny = edge(g_img,'canny',[0.15 0.45]);
figure
imshow((canny));
title("Canny output image");

writeraw(canny/255, "Canny_probability_map.raw" , 1);
writeraw(canny, "Canny_pig_out.raw" , 1);



