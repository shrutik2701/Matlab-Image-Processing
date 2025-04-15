% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 10 Feb 2024
% Problem 1 : Image warping

close all;
% Read image
img = readraw("cat.raw",328,328,0);
figure;
imshow(uint8(img));
title("Original image");
row = size(img,1);
col = size(img,2);

% Forward warping
warped_img = zeros(row,col,3);

for i=1:row
    for j=1:col
        if (i==j || i+j==row)
            
            warped_img(i,j,2) = img(i,j,2);
            warped_img(i,j,3) = img(i,j,3);
            continue;
        end
        % Converting to cartesian co-cord.
        x = j - 0.5 ;
        y = row + 0.5 - i +1;

        % Place origin at the middle of image
        x_m = x - col/2;
        y_m = y - row/2;

        % different logics for every triangle
        if(y_m>0 && y_m>= abs(x_m))  % upper triangle : 1
            
            u = x_m;
            v = y_m + 0.0024*x_m*x_m - 0.0024*y_m*y_m;
            
        elseif (y_m<0 && abs(y_m)>=abs(x_m)) % lower tri 2
           
            u = x_m;
            v = y_m - 0.0024*x_m*x_m + 0.0024*y_m*y_m;

        elseif (x_m<0 && abs(x_m)>= abs(y_m)) % left tri 3
            
            v = y_m;
            u = x_m +0.0024*x_m*x_m - 0.0024*y_m*y_m;

        elseif ((x_m>0 && abs(x_m)>= abs(y_m))) % right tri 4
           
            v = y_m;
            u = x_m -0.0024*x_m*x_m + 0.0024*y_m*y_m;
        end

        % Reverse mapping to image pixel location
            x_c = floor(u + 0.5 + col/2);
            y_c = (floor(-v +row/2 +0.5 +1));

            warped_img(y_c,x_c,1) = img(i,j,1);
            warped_img(y_c,x_c,2) = img(i,j,2);
            warped_img(y_c,x_c,3) = img(i,j,3);

    end
end

figure;
imshow(uint8(warped_img));
title("Warped image");

% Reverse spatial warping
org = zeros(row,col,3);

for i=1:row
    for j=1:col
        if (i==j || i+j==row)
            org(i,j,1) = warped_img(i,j,1);
            org(i,j,2) = warped_img(i,j,2);
            org(i,j,3) = warped_img(i,j,3);
            continue;
        end
        % Converting to cartesian co-cord.
        x = j - 0.5 ;
        y = row + 0.5 - i +1;

        % Place origin at the middle of image
        x_m = x - col/2;
        y_m = y - row/2;

        % different logics for every triangle
        if(y_m>0 && y_m>= abs(x_m))  % upper triangle : 1
            u = x_m;
            v = y_m + 0.0024*x_m*x_m - 0.0024*y_m*y_m;
            
        elseif (y_m<0 && abs(y_m)>=abs(x_m)) % lower tri 2
            u = x_m;
            v = y_m - 0.0024*x_m*x_m + 0.0024*y_m*y_m;

        elseif (x_m<0 && abs(x_m)>= abs(y_m)) % left tri 3
            v = y_m;
            u = x_m +0.0024*x_m*x_m - 0.0024*y_m*y_m;

        elseif ((x_m>0 && abs(x_m)>= abs(y_m))) % right tri 4
            v = y_m;
            u = x_m -0.0024*x_m*x_m + 0.0024*y_m*y_m;
        end

        % Reverse mapping to image pixel location
            x_c = floor(u + 0.5 + col/2);
            y_c = (floor(-v +row/2 +0.5 +1));

            org(i,j,1)= warped_img(y_c,x_c,1);
            org(i,j,2)= warped_img(y_c,x_c,2);
            org(i,j,3)= warped_img(y_c,x_c,3);

    end
end

figure;
imshow(uint8(org));
title('Reconstructed image');

