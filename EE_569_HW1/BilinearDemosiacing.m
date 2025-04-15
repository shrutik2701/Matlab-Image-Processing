% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 28 Jan, 2024

clear all; close all;
% Assuming 1st box to be green pixel

% Reading the raw image
org = (readraw( "house.raw" , 288,420,1));
img = zeros([290,422]);
figure;
imshow(uint8(org));

% Zeropad for borders
for i=2:289
    for j=2:421
        img(i,j) = org(i-1,j-1);
    end
end

% Demosiaced image
img_d = zeros(288,420,3);

% demosiacing operation
k=1;
g_m = [0 1/4 0; 1/4 0 1/4; 0 1/4 0];
vertical_mat = [0 0.5 0; 0 0 0; 0 0.5 0]; % for (i-1,j)(i+1,j) kind of locations
horiz_mat = [0 0 0; 0.5 0 0.5; 0 0 0];  % for (i,j-1)(i,j+1) kind of locations


for i=2:289
    for j = 2:421
            if(mod((i+j), 2) == 0)
                if(mod(i,2)) % green
                   img_d(i-1,j-1,k) = conv_img(img(i-1:i+1,j-1:j+1),vertical_mat);   % R
                   img_d(i-1,j-1,k+1) = img(i,j); % G
                   img_d(i-1,j-1,k+2) = conv_img(img(i-1:i+1,j-1:j+1),horiz_mat); % B
                else
                    img_d(i-1,j-1,k) = conv_img(img(i-1:i+1,j-1:j+1),horiz_mat);
                    img_d(i-1,j-1,k+1) = img(i,j);
                    img_d(i-1,j-1,k+2) = conv_img(img(i-1:i+1,j-1:j+1),vertical_mat);
                end
            elseif(mod(i,2)==0) % red
                img_d(i-1,j-1,k) = img(i,j);
                img_d(i-1,j-1,k+1) = conv_img(img(i-1:i+1,j-1:j+1),g_m);
                img_d(i-1,j-1,k+2) = conv_img(img(i-1:i+1,j-1:j+1),vertical_mat);
            else % blue
                img_d(i-1,j-1,k) = conv_img(img(i-1:i+1,j-1:j+1),g_m);
                img_d(i-1,j-1,k+1) =conv_img(img(i-1:i+1,j-1:j+1),vertical_mat);
                img_d(i-1,j-1,k+2) = img(i,j);
            end
    end
end

writeraw(img_d,"Bilinear_demosaicing_output.raw",0);

figure;
imshow(uint8(img_d));
