% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 29 Mar, 2024

clear all; close all;
img = imread('composite.png');
figure;
imshow(img);

r = 512; c = 512;

% S2: Apply laws filter
img = zero_pad(img,5); % zeropad so can calc conv
k=1;
laws_filters = [ [1 4 6 4 1]; [-1 -2 0 2 1]; [-1 0 2 0 -1]; [-1 2 0 -2 1]; [1 -4 6 -4 1] ];
for i=1:5
    for j=1:5
        now_filt = laws_filters(i,:)'*laws_filters(j,:);
        op_img = conv_new_img(img,now_filt,r,c);
        filtered_imgs(1:r,1:c,k) = op_img;              % op of laws filters
        k = k+1;
    end
end

% Energy feature computation using window 
win_size = 9;
for k = 1:25
    feat_img = zero_pad(filtered_imgs(:,:,k),win_size);
    pixel_features(:,k) = calc_pixel_energy(feat_img, win_size,r,c);
end

% Normalizing using L5'*L5 
pixel_features_1 = pixel_features./pixel_features(:,1);
pixel_features_1 = double(pixel_features_1(:,2:25));

% applying kmeans
labs = kmeans(pixel_features_1,5, 'Distance', 'cityblock', 'MaxIter', 10000,'Replicates',5,'Start','cluster');
k=1;
for j=1:r
    for i=1:c
        if(labs(k)==1)
            I_S_i(j,i)=0;
        elseif(labs(k)==2)
            I_S_i(j,i)=63;
        elseif(labs(k)==3)
            I_S_i(j,i)=127;
        elseif(labs(k)==4)
            I_S_i(j,i)=191;
        else
            I_S_i(j,i)= 255;
        end
        k=k+1;
    end
end

figure;
imshow(uint8(I_S_i'));
title('Kmeans segmented without pca');


%% Load the original features obtained from problem 2 (a)

ori = pixel_features_1;
% Apply PCA 
coeff = pca(ori);
pca_red = ori*coeff(:,1:6);

[clus_in, cen_loc] = kmeans(pca_red, 5,"MaxIter",10000, 'Distance','cityblock');

% label each pixel

lab = zeros(rows,cols);
m =1;
n =1;
for i = 1:size(clus_in,1)
    lab(m,n) = clus_in(i,1);
    n = n+1;

    if(mod(i,512)==0)
        m = m+1;
        n = 1;
    end
end

for m = 1:r
    for n = 1:c
        if lab(m,n) == 1
            o2d(m,n) = 0;
        elseif lab(m,n) == 2
            o2d(m,n) = 63;
        elseif lab(m,n) == 3
            o2d(m,n) = 127;
        elseif lab(m,n) == 4
            o2d(m,n) = 191;
        elseif lab(m,n) == 5
            o2d(m,n) = 255;
        end
    end
end

figure;
imshow(uint8(o2d'));
title("Output of Advanced texture segmentation");


%% Functions used

function op = conv_new_img(img,filt,r,c)
for i=3:r+2
    for j=3:c+2
        op(i-2,j-2) = conv_img(img(i-2:i+2,j-2:j+2),filt);
    end
end
end



function v = calc_pixel_energy(img, s,r,c)

for i= 1+(s-1)/2 : r+(s-1)/2
    for j = 1+(s-1)/2 : c+(s-1)/2
        v1(i-(s-1)/2,j-(s-1)/2) = energyy(img(i-(s-1)/2:i+(s-1)/2, j-(s-1)/2:j+(s-1)/2),s);
    end
end
v = v1(:);
end

function e = energyy(im,s)
e = 0.0;
for i=1:s
    for j=1:s
        e = e + (im(i,j)*im(i,j))/s/s;
    end
end
end

function paddedImg = zero_pad(img, kernel_size)
    [rows, cols] = size(img);
    padSize = ((kernel_size-1) / 2);

    % Pad the image
    paddedImg = zeros(rows+2*padSize, cols+2*padSize);
    for i=1:rows
        for j=1:cols
            paddedImg(i+padSize,j+padSize) = img(i,j);
        end
    end
end