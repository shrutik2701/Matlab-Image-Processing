% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 10 Feb 2024
% Problem 3c: Object segmentation and analysis

close all;
img = readraw('beans.raw',82,494,0);
row = size(img,1);
col =  size(img,2);
figure;
imshow(uint8(img));
title('Original image');

% Conversion to grayscale
g_img(:,:) = 0.299*img(:,:,1) + 0.587*img(:,:,2) + 0.114*img(:,:,3);
figure;
imshow(uint8(g_img));
title('Gray image');

% Binarization & inversion
F_max = max(max(g_img));
for i=1:row
    for j=1:col
        if g_img(i,j)>0.95*F_max
            g_img(i,j)=0;
        else
            g_img(i,j)=1;
        end
    end
end
figure;
imshow((g_img));
title('Binary image');

for i =2:row-1
    for j=2:col-1
        cpat = g_img(i-1:i+1,j-1:j+1);
        if cpat == [1 1 1; 1 0 1; 1 1 1] 
            g_img(i,j)=1;
        elseif cpat == [1 1 1; 1 0 0; 1 1 1]
            g_img(i,j) = 1;
        end
    end
end
figure;
imshow((g_img));
title('Removed holes');

shrink_g = bwmorph(g_img,'shrink',Inf);
figure;
imshow((shrink_g));
title('Shrinked image');

% count beans
count_beans =0;
for i = 2:row-1
    for j= 2:col-1
        cpat = shrink_g(i-1:i+1,j-1:j+1);
        if cpat == [ 0 0 0; 0 1 0; 0 0 0]
            count_beans = count_beans+1;
        end
    end
end



% PART - 2
var = bwconncomp(g_img);
S = regionprops(var,'Centroid');
for i=1:5
    c = floor(S(i).Centroid(1));
    if c-60>=1 && c+60<=494
      req_img = img(:,c-60:c+60,:);
      req_img_seg = g_img(:,c-60:c+60);
    else
      req_img = img(:,c-30:c+30,:);
      req_img_seg = g_img(:,c-30:c+30);
    end
    figure;
    subplot(1,2,1);
    imshow(uint8(req_img));
    title('Bean extracted');
    subplot(1,2,2);
    imshow(req_img_seg);
    title('Segmentation mask');
end

S = regionprops(var,'Area'); % Size of image 
for i=1:5
    mat(i,1) = S(i).Area;
    mat(i,2) = i;
end
% Arrange beans sizes from biggest to smallest
for i=1:4
    for j=i+1:5
        if(mat(i,1)<mat(j,1))
            temp = mat(i,1);
            mat(i,1) = mat(j,1);
            mat(j,1) = temp;
            temp = mat(i,2);
            mat(i,2) = mat(j,2);
            mat(j,2) = temp;
        end
    end
end



