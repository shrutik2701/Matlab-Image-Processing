% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 10 Feb 2024
% Problem 2: Homographic transformation and image stitching

close all;

% Read the right, centre, left input images
ip_l = readraw("toys_left.raw", 454, 605, 0);
l_img = uint8(ip_l);

ip_m = readraw("toys_middle.raw", 454, 605, 0);
m_img = uint8(ip_m);

ip_r = readraw("toys_right.raw", 454, 605, 0);
r_img = uint8(ip_r);

[rows,cols,g] = size(ip_l);

% Convert it to grey scale
l_grey = im2gray(l_img);
m_grey = im2gray(m_img);
r_grey = im2gray(r_img);

% Find matching point pairs and features from images
P1 = detectSURFFeatures(l_grey);
[fea_l, validP_l] = extractFeatures(l_grey, P1);
P2 = detectSURFFeatures(m_grey);
[fea_m, validP_m] = extractFeatures(m_grey, P2);
P3 = detectSURFFeatures(r_grey);
[fea_r, validP_r] = extractFeatures(r_grey, P3);

% Match the features
i_pairs_ML = matchFeatures(fea_m, fea_l,'Unique',true);
i_pairs_MR = matchFeatures(fea_m, fea_r,'Unique',true);

% Match points
mpL = validP_l(i_pairs_ML(:, 2), :);  % left
mpR = validP_r(i_pairs_MR(:, 2), :);  % right
mpML = validP_m(i_pairs_ML(:, 1), :);    % middle to left
mpMR = validP_m(i_pairs_MR(:, 1), :);    % middle to right

% Display matched points
figure;
showMatchedFeatures(m_grey, l_grey, mpML, mpL, 'montage');
legend('points matched on middle','points matched on left');

figure;
showMatchedFeatures(m_grey, r_grey, mpMR, mpR, 'montage');
legend('points matched on middle','points matched on right');

% (1.3) Check the matched SURF points by plotting them on the left and middle images
figure;
title('Left and middle image matched features');
subplot(2,1,1);
imshow(l_grey);
axis on;
hold on;
plot(mpL([21,16,2,4]));

subplot(2,1,2); imshow(m_grey);
axis on;
hold on;
plot(mpML([21,16,2,4]));

% (1.4) Check the matched SURF points by plotting them on right and middle images
figure;
title('Middle and right image matched features');
subplot(2,1,1); imshow(r_grey);
axis on;
hold on;
plot(mpR([21,6,12,32]));

subplot(2,1,2); imshow(m_grey);
axis on;
hold on;
plot(mpMR([21,6,12,32]));


% Creating the canvas
can = zeros(1100, 1974, 3);

% left and right offset = {1495 - (width*3)}/2 =  80
% top and bottom offset = {1100-(height)}/2 = 323

% left
can(322:775, 1:605, 1) = l_img(:,:,1);
can(322:775, 1:605, 2) = l_img(:,:,2);
can(322:775, 1:605, 3) = l_img(:,:,3);
% middle
can(322:775, 605+80:605+80+605-1, 1) = m_img(:,:,1);
can(322:775, 605+80:605+80+605-1, 2) = m_img(:,:,2);
can(322:775, 605+80:605+80+605-1, 3) = m_img(:,:,3);
% right
can(322:775, (605+80)*2:605*3+80*2-1, 1) = r_img(:,:,1);
can(322:775, (605+80)*2:605*3+80*2-1, 2) = r_img(:,:,2);
can(322:775, (605+80)*2:605*3+80*2-1, 3) = r_img(:,:,3);

% display canvas 
figure;
imshow(uint8(can));
title('Placing left-middle-right images on canvas')

% (4) Select 4 matching points for each
% left
l_x = mpL.Location([21,16,2,4],1);
l_y = mpL.Location([21,16,2,4],2);

% middle-left
m_x =  mpML.Location([21,16,2,4],1);
m_y =  mpML.Location([21,16,2,4],2);

% middle-right
m_r_x =  mpMR.Location([21,6,12,32],1);
m_r_y =  mpMR.Location([21,6,12,32],2);

% right
r_x = mpR.Location([21,6,12,32],1);
r_y = mpR.Location([21,6,12,32],2);

% (5) Transform the matching points to be on the same scale as our canvas
% left % left x value remains unchanged
l_y = l_y + 322; % add the offset at the bottom of canvas

% middle left
m_x = m_x + 605+80; % add width of left + offset
m_y = m_y + 322; % add offset at bottom

% middle right
m_r_x = m_r_x + 605+80;
m_r_y = m_r_y + 322;

% right 
r_x = r_x + (605+80)*2; % add width of left and middle + 2*offest
r_y = r_y + 322; % add offset at bottom

% (6.1) Use the left and middle-left 4 points to construct homography matrix for left image
% Construct the variables and equations
syms h11_l h12_l h13_l h21_l h22_l h23_l h31_l h32_l
eqn1 = h11_l*l_x(1) + h12_l*l_y(1) + h13_l == m_x(1)*(h31_l*l_x(1) + h32_l*l_y(1) + 1);
eqn2 = h21_l*l_x(1) + h22_l*l_y(1) + h23_l == m_y(1)*(h31_l*l_x(1) + h32_l*l_y(1) + 1);
eqn3 = h11_l*l_x(2) + h12_l*l_y(2) + h13_l == m_x(2)*(h31_l*l_x(2) + h32_l*l_y(2) + 1);
eqn4 = h21_l*l_x(2) + h22_l*l_y(2) + h23_l == m_y(2)*(h31_l*l_x(2) + h32_l*l_y(2) + 1);
eqn5 = h11_l*l_x(3) + h12_l*l_y(3) + h13_l == m_x(3)*(h31_l*l_x(3) + h32_l*l_y(3) + 1);
eqn6 = h21_l*l_x(3) + h22_l*l_y(3) + h23_l == m_y(3)*(h31_l*l_x(3) + h32_l*l_y(3) + 1);
eqn7 = h11_l*l_x(4) + h12_l*l_y(4) + h13_l == m_x(4)*(h31_l*l_x(4) + h32_l*l_y(4) + 1);
eqn8 = h21_l*l_x(4) + h22_l*l_y(4) + h23_l == m_y(4)*(h31_l*l_x(4) + h32_l*l_y(4) + 1);

% put the variables and equations into a matrix
[A,B] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4, eqn5, eqn6, eqn7, eqn8], [h11_l, h12_l, h13_l, h21_l, h22_l, h23_l, h31_l, h32_l]);

% linsolve the matrix
X = linsolve(A,B);

% (6.2) fill the variables and construct the matrix
h11_l = double(X(1));
h12_l = double(X(2));
h13_l = double(X(3));
h21_l = double(X(4));
h22_l = double(X(5));
h23_l = double(X(6));
h31_l = double(X(7));
h32_l = double(X(8));
h33_l = double(1);

l_homog_mat = [h11_l h12_l h13_l; h21_l h22_l h23_l; h31_l h32_l h33_l];

% (7.1) Use the left and middle-left 4 points to construct homography matrix for left image
% Construct the variables and equations
syms h11_r h12_r h13_r h21_r h22_r h23_r h31_r h32_r
eqn1 = h11_r*r_x(1) + h12_r*r_y(1) + h13_r == m_r_x(1)*(h31_r*r_x(1) + h32_r*r_y(1) + 1);
eqn2 = h21_r*r_x(1) + h22_r*r_y(1) + h23_r == m_r_y(1)*(h31_r*r_x(1) + h32_r*r_y(1) + 1);
eqn3 = h11_r*r_x(2) + h12_r*r_y(2) + h13_r == m_r_x(2)*(h31_r*r_x(2) + h32_r*r_y(2) + 1);
eqn4 = h21_r*r_x(2) + h22_r*r_y(2) + h23_r == m_r_y(2)*(h31_r*r_x(2) + h32_r*r_y(2) + 1);
eqn5 = h11_r*r_x(3) + h12_r*r_y(3) + h13_r == m_r_x(3)*(h31_r*r_x(3) + h32_r*r_y(3) + 1);
eqn6 = h21_r*r_x(3) + h22_r*r_y(3) + h23_r == m_r_y(3)*(h31_r*r_x(3) + h32_r*r_y(3) + 1);
eqn7 = h11_r*r_x(4) + h12_r*r_y(4) + h13_r == m_r_x(4)*(h31_r*r_x(4) + h32_r*r_y(4) + 1);
eqn8 = h21_r*r_x(4) + h22_r*r_y(4) + h23_r == m_r_y(4)*(h31_r*r_x(4) + h32_r*r_y(4) + 1);

% put the variables and equations into a matrix
[A,B] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4, eqn5, eqn6, eqn7, eqn8], [h11_r, h12_r, h13_r, h21_r, h22_r, h23_r, h31_r, h32_r]);

% linsolve the matrix
X = linsolve(A,B);

% (7.2) fill the variables and construct the matrix
h11_r = double(X(1));
h12_r = double(X(2));
h13_r = double(X(3));
h21_r = double(X(4));
h22_r = double(X(5));
h23_r = double(X(6));
h31_r = double(X(7));
h32_r = double(X(8));
h33_r = double(1);

r_homog_mat = [h11_r h12_r h13_r; h21_r h22_r h23_r; h31_r h32_r h33_r];

% Stitched image
Stitched_img = zeros(1100, 1974, 3);
Stitched_img(322:775, 605+80:605+80+605-1, 1) = m_img(:,:,1);
Stitched_img(322:775, 605+80:605+80+605-1, 2) = m_img(:,:,2);
Stitched_img(322:775, 605+80:605+80+605-1, 3) = m_img(:,:,3);
Stitched_img = uint8(Stitched_img);

% Multiply the left image with the homography matrix
% loop through the left image
for i = 1:454
    for j = 1:605
        for k = 1:3
         
            % convert the coordinates to cartesian coordinates of our canvas
            x = j-0.5;
            y = i+323-0.5;

            % get the intermediate values
            x_prime = x*l_homog_mat(1,1) + y*l_homog_mat(1,2) + l_homog_mat(1,3);
            y_prime = x*l_homog_mat(2,1) + y*l_homog_mat(2,2) + l_homog_mat(2,3);
            w_prime = x*l_homog_mat(3,1) + y*l_homog_mat(3,2) + l_homog_mat(3,3);

            % calculate the new cartesian values
            x_new = x_prime/w_prime;
            y_new = y_prime/w_prime;

            % get the new canvas location
            i_canvas = round(y_new-0.5);
            j_canvas = round(x_new+0.5);

            % First, check if we are in the original region
            if ((322<=i_canvas)&&(i_canvas<=775)) && ((605+80<=j_canvas)&&(j_canvas<=605+80+605-1))
                % if in original region, output normal
                Stitched_img(i_canvas, j_canvas, k) = Stitched_img(i_canvas, j_canvas, k);
            else
                Stitched_img(i_canvas, j_canvas, k) = l_img(i,j,k);
            end
        end
    end
end

% Intermediate step to inspect results
% figure;
% imshow(Stitched_img);


% Multiply the right image with the homograpy matrix
% loop through the right image
for i = 1:454
    for j = 1:605
        for k = 1:3
            
            % convert the coordinates to cartesian coordinates of our canvas
            x = (j+(605+80)*2)-0.5;
            y = (i+323)-0.5;

            % get the intermediate values
            x_prime = x*r_homog_mat(1,1) + y*r_homog_mat(1,2) + r_homog_mat(1,3);
            y_prime = x*r_homog_mat(2,1) + y*r_homog_mat(2,2) + r_homog_mat(2,3);
            w_prime = x*r_homog_mat(3,1) + y*r_homog_mat(3,2) + r_homog_mat(3,3);

            % calculate the new cartesian values
            x_new = x_prime/w_prime;
            y_new = y_prime/w_prime;

            % get the new canvas location
            i_canvas = round(y_new-0.5);
            j_canvas = round(x_new+0.5);
            % First, check if we are in the original region
            if ((285<=i_canvas)&&(i_canvas<=771)) && ((587<=j_canvas)&&(j_canvas<=911))
                % if in original region, output normal
                Stitched_img(i_canvas, j_canvas, k) = (Stitched_img(i_canvas, j_canvas, k));
                continue;
            else
                Stitched_img(i_canvas, j_canvas, k) = r_img(i,j,k);
            end
        end
    end
end

% plz work
figure; imshow(Stitched_img);
title('Stitched image before interpolation');
Stitched_final = Stitched_img;

% loop through the image and take the average on black pixel locations
% loop through the canvas
for i = 2:1099
    for j = 2:1973
        for k = 1:3
            % if we are on a black pixel
            if Stitched_img(i,j, k) == 0
                % check neighbors
                % top left
                if Stitched_img(i-1, j-1, k) ~= 0
                    Stitched_final(i,j,k) = Stitched_img(i-1, j-1, k);
                % top
                elseif Stitched_img(i-1, j, k) ~= 0
                    Stitched_final(i,j,k) = Stitched_img(i-1, j, k);
                % top right
                elseif Stitched_img(i-1, j+1, k) ~= 0
                    Stitched_final(i,j,k) = Stitched_img(i-1, j+1, k);
                % left
                elseif Stitched_img(i, j-1, k) ~= 0
                    Stitched_final(i,j,k) = Stitched_img(i, j-1, k);
                % right
                elseif Stitched_img(i, j+1, k) ~= 0
                    Stitched_final(i,j,k) = Stitched_img(i, j+1, k);
                % bottom left
                elseif Stitched_img(i+1, j-1, k) ~= 0
                    Stitched_final(i,j,k) = Stitched_img(i+1, j-1, k);
                % bottom right
                elseif Stitched_img(i+1, j+1, k) ~= 0
                    Stitched_final(i,j, k) = Stitched_img(i+1, j+1, k);
                % bottom
                elseif Stitched_img(i+1, j, k) ~= 0
                    Stitched_final(i,j,k) = Stitched_img(i+1, j, k);
                end
            end
        end
    end
end

figure;
imshow(Stitched_final);
title("Final image")



