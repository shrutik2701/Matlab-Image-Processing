% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 29 Mar, 2024

clear all;
close all;

cat_1 = imread("cat_3.png");

cat_2 = imread("cat_2.png");

cat_3 = imread("cat_1.png");

dog_1 = imread("dog_1.png");


% Convert to grey-scale image
c1_g = single(rgb2gray(cat_1));
c2_g = single(rgb2gray(cat_2));
c3_g = single(rgb2gray(cat_3));
d_g = single(rgb2gray(dog_1));

% Extract SIFT features
[f1,d1] = vl_sift(c1_g);
[f2,d2] = vl_sift(c2_g);
[f3,d3] = vl_sift(c3_g);%,'Levels',28,'WindowSize',7,'PeakThresh',0.02,'EdgeThresh',7.5);
[f4,d4] = vl_sift(d_g);%,'Levels',28,'WindowSize',7,'PeakThresh',0.02,'EdgeThresh',7.5);

save("d1.mat");
save("d2.mat");
save("d3.mat");
save("d4.mat");

% Largest score in SIFT features for cat_1 and find index
high_cat_1 = Highest_Index(f1);
disp("The highest score: "+f1(3,high_cat_1)+" is associated with index: "+high_cat_1);

% Associated feature in cat_3
minDist = 10000000000000000;
minIndex = 0;
desc_cat_1 = double(d1(:,high_cat_1));           % load cat_1 descriptor

% cat_3
[rows,cols] = size(d3);
for i = 1:cols
    desc_cat_3 = double(d3(:,i));               % descriptor for cat_3
d = sum((desc_cat_1 - desc_cat_3).^2);        % calculate distance
    
    if d < minDist         
        minIndex = i;
        minDist = d;
    end
end
disp("The minimum index is: "+minIndex);

%% Plot keypoints along with the frame and descriptors for cat-1 and cat-3
figure;
sgtitle("Keypoints plotted for cat-1 and cat-3");
subplot(1,2,1);
imshow(cat_1);
h1_cat_1 = vl_plotframe(f1(:,high_cat_1));
set(h1_cat_1,'color','y','linewidth',2) ;
h3_cat_1 = vl_plotsiftdescriptor(d1(:,high_cat_1),f1(:,high_cat_1)) ;
set(h3_cat_1,'color','g') ;

subplot(1,2,2);
imshow(cat_3);
h1_cat_3 = vl_plotframe(f3(:,minIndex));
set(h1_cat_3,'color','y','linewidth',2);
h3_cat_3 = vl_plotsiftdescriptor(d3(:,minIndex),f3(:,minIndex)) ;
set(h3_cat_3,'color','g') ;


% 1. match for cat_1 and cat_3
[match score] = vl_ubcmatch(d1,d3,1.35);  
figure;
imshow([cat_1 cat_3]);
title("Cat-1 and Cat-3");
x1 = f1(1,match(1,:)) ;
x2 = f3(1,match(2,:)) + size(cat_1,2) ;
y1 = f1(2,match(1,:));
y2 = f3(2,match(2,:)) ;
hold on ;
z = line([x1 ; x2], [y1 ; y2]) ;
set(z,'linewidth', 1, 'color', 'b') ;
vl_plotframe(f1(:,match(1,:))) ;
f3(1,:) = f3(1,:) + size(cat_1,2) ;
vl_plotframe(f3(:,match(2,:))) ;
axis image off ;
hold off;

%2. Match for cat_3 and cat_2
[match score] = vl_ubcmatch(d3,d2,1.35);    %threshold originally is 1.35
figure; 
imshow([cat_3 cat_2]);
title("Cat-3 and Cat-2");
x1 = f3(1,match(1,:)) ;
x2 = f2(1,match(2,:)) + size(cat_3,2) ;
y1 = f3(2,match(1,:)) ;
y2 = f2(2,match(2,:)) ;
hold on ;
z = line([x1 ; x2], [y1 ; y2]) ;
set(z,'linewidth', 1, 'color', 'b') ;
vl_plotframe(f3(:,match(1,:))) ;
f2(1,:) = f2(1,:) + size(cat_3,2) ;
vl_plotframe(f2(:,match(2,:))) ;
axis image off ;
hold off;

%3. match for dog_1 and cat_3
[match score] = vl_ubcmatch(d4,d3,1.35);         %threshold originally is 1.35
figure;
imshow([dog_1 cat_3]);
title("Dog and Cat-3");
x1 = f4(1,match(1,:)) ;
x2 = f3(1,match(2,:)) + size(dog_1,2) ;
y1 = f4(2,match(1,:));
y2 = f3(2,match(2,:)) ;
hold on ;
z = line([x1 ; x2], [y1 ; y2]) ;
set(z,'linewidth', 1, 'color', 'b') ;
vl_plotframe(f4(:,match(1,:))) ;
f3(1,:) = f3(1,:) + size(dog_1,2) ;
vl_plotframe(f3(:,match(2,:))) ;
axis image off ;
hold off;
% 
% 4. match for cat_1 and dog_1
[match score] = vl_ubcmatch(d1,d4,1.35);         %threshold originally is 1.35
figure;
imshow([cat_1 dog_1]);
title("Cat-1 and Dog-1");
x1 = f1(1,match(1,:)) ;
x2 = f4(1,match(2,:)) + size(cat_1,2) ;
y1 = f1(2,match(1,:));
y2 = f4(2,match(2,:)) ;
hold on ;
z = line([x1 ; x2], [y1 ; y2]) ;
set(z,'linewidth', 1, 'color', 'b') ;
vl_plotframe(f1(:,match(1,:))) ;
f4(1,:) = f4(1,:) + size(cat_1,2) ;
vl_plotframe(f4(:,match(2,:))) ;
axis image off ;
hold off;

function index = Highest_Index(frames)
    index = 0;
    score = 0;

    % loop through all of the scales
    [rows,cols] = size(frames);
    for i = 1:cols
       current_score = frames(3,i);
       if current_score > score
           high_score = current_score;
           index = i;
       end
    end
end