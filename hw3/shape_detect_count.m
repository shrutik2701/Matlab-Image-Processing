% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 10 Feb 2024
% Problem 3b: Shape detection & Counting

close all;
img = readraw('board.raw',768,768,1);
row = size(img,1);
col =  size(img,2);

figure;
imshow(uint8(img));
title('Original image');

% Binarization & inversion
F_max = max(max(img));
for i=1:row
    for j=1:col
        if img(i,j)>0.5*F_max
            img(i,j)=0;
        else
            img(i,j)=255;
        end
    end
end

figure;
imshow(uint8(img));
title('Binary image');

shrinked_img = bwmorph(img,'shrink',inf);
figure;
imshow((shrinked_img));

% pattern to detect
pat = [0 0 0; 0 1 0; 0 0 0];
count_holes = 0;

% zero-padding shrinked img
pad_shr_im = zeros(row+2,col+2);
pad_shr_im(2:row+1,2:col+1) = shrinked_img;

for i= 2:row+1
    for j=2:col+1
        check_mat = pad_shr_im(i-1:i+1,j-1:j+1);
        if check_mat == pat
            count_holes = count_holes+1; % number of dots
            pad_shr_im(i,j) = 0; % needed for 2nd part - removing the holes
        end
    end
end

% Inverting for the 2nd part
for i=1:row+2
    for j=1:col+2
        if pad_shr_im(i,j) == 1
            pad_shr_im(i,j) = 0;
        
        else
            pad_shr_im(i,j) = 1;
        end
        
    end
end
% thicken black edges for better results
for i=1:row+2
    for j=1:col+2
       if (j<col+1 && pad_shr_im(i,j+1) == 0) || (i<col+1 && pad_shr_im(i+1,j) == 0)
            pad_shr_im(i,j) = 0;
       end
    end
end
figure;
imshow(pad_shr_im);
title('After 2nd inversion');


pad_shr_2 = bwmorph(pad_shr_im,'shrink',inf);
figure;
imshow(pad_shr_2);
title('After 2nd shrink');

% Check with the above declared pattern 'pat'
count_shapes = 0;
for i= 2:row+1
    for j=2:col+1
        check_mat = pad_shr_2(i-1:i+1,j-1:j+1);
        if check_mat(:) == pat(:)  
            count_shapes = count_shapes+1; % number of shapes
            %pad_shr_im(i,j) = 0; % needed for 2nd part - removing the holes
        end
    end
end

% for 3rd part 
% Fill holes
islands = bwlabel(img);
imshow(islands);
for i=1:row
    for j=1:col
        if islands(i,j) > 1
            islands(i,j) =0;
        end
    end
end
imshow(islands);
title('Filled holes');

img2 = islands;
for i=1:row
    for j=1:col
        if img2(i,j) == 1
            img2(i,j) = 0;
        else
            img2(i,j) = 1;
        end
    end
end
figure;
imshow(img2);
title('Inverted filled holes');

% Perform thinning
thin_img = bwmorph(img2,'thin',Inf);
thin_img = bwmorph(thin_img,'shrink',1);
figure;
imshow(thin_img);
title('After thinning');





% counting white circles
count_circle = 0;
pad_thin_im = zeros(row+2,col+2);
pad_thin_im(2:row+1,2:col+1) = thin_img;

for i= 2:row+1
    for j=2:col+1
        check_mat = pad_thin_im(i-1:i+1,j-1:j+1);
        if check_mat == pat 
            count_circle = count_circle+1; % number of dots
            pad_thin_im(i,j) = 0; % needed for 3rd part - removing the holes
        end
    end
end
figure;
imshow(pad_thin_im);
title('After detecting circles n removing them');

%shrink again 
shrinked_pad_thin_im = bwmorph(pad_thin_im,'shrink',inf);
figure;
imshow(shrinked_pad_thin_im);
title('After shrinking without circles');

% counting rectangles
count_rect = 0;
for i= 2:row+1
    for j=2:col+1
        check_mat = shrinked_pad_thin_im(i-1:i+1,j-1:j+1);
        if check_mat == pat 
            count_rect = count_rect+1; % number of dots
        end
    end
end