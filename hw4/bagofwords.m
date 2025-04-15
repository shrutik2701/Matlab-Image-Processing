% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 29 Mar, 2024

% Load the descriptors
clear all;
close all;

% Load the descriptors
d = load("d1.mat");
d1 = d.d1;
d = load("d2.mat");
d2 = d.d2;
d = load("d3.mat");
d3 = d.d3;
d = load("d4.mat");
d4 = d.d4;


% Reduce the dimension of features from 128 to 20
dt1 = double(d1');          % for cat-1 image
p1 = pca(dt1);
d1_new = dt1*p1(:,1:20);

dt2 = double(d2');          % for cat-2 image
p2 = pca(dt2);
d2_new = dt2*p2(:,1:20);

dt3 = double(d3');          % for cat-1 image
p3 = pca(dt3);
d3_new = dt3*p3(:,1:20);

dt4 = double(d4');          % for cat-1 image
p4 = pca(dt4);
d4_new = dt4*p4(:,1:20);

% Combine the PCA's of all images
com = [];
com = [com; d1_new; d2_new; d3_new; d4_new];

% Apply kmeans algorithm with 8 clusters
[clus, cen] = kmeans(com,8,"MaxIter",100000,'Distance','sqeuclidean');

% separate each image features
c1 = clus(1:size(d1_new,1),:);
c2 = clus(size(d1_new,1)+1 : size(d1_new,1)+1+size(d2_new,1),:);
c3 = clus(size(d1_new,1)+1+size(d2_new,1)+1:size(d1_new,1)+1+size(d2_new,1)+1+size(d3_new),:);
d = clus(size(d1_new,1)+1+size(d2_new,1)+1+size(d3_new)+1:size(d1_new,1)+1+size(d2_new,1)+1+size(d3_new,1)+1+size(d4,1),:);
% Calculate Histogram
bins = 8;
c1_hist = hist(c1,bins);
c2_hist = hist(c2,bins);
c3_hist = hist(c3,bins);
d_hist = hist(d,bins);

figure;
subplot(2,2,1);
bar(c1_hist);
title("Histogram of Cat-1 Image");
xlabel("Number of bins");
ylabel("Frequency");

subplot(2,2,2);
bar(c2_hist);
title("Histogram of Cat-2 Image");
xlabel("Number of bins");
ylabel("Frequency");
subplot(2,2,3);
bar(c3_hist);
title("Histogram of Cat-3 Image");
xlabel("Number of bins");
ylabel("Frequency");
subplot(2,2,4);
bar(d_hist);
title("Histogram of Dog Image");
xlabel("Number of bins");
ylabel("Frequency");

% Normalizing Histogram
c1_n = norm(c1_hist,bins);
c2_n = norm(c2_hist,bins);
c3_n = norm(c3_hist,bins);
d_n = norm(d_hist,bins);

% Calculate Similarity Index
SI_cat3_cat1 = SimInd(c3_n,c1_n,bins);
SI_cat3_cat2 = SimInd(c3_n,c2_n,bins);
SI_cat3_dog = SimInd(c3_n,d_n,bins);

disp("Similarity Index between cat-3 and cat-1 : "); disp(SI_cat3_cat1);
disp("Similarity Index between cat-3 and cat-2 : "); disp(SI_cat3_cat2);
disp("Similarity Index between cat-3 and Dog : "); disp(SI_cat3_dog);

function SimInd = SimInd(A,B,bins)
    min_sum = 0;
    max_sum = 0;
    for i = 1:bins
        min_sum = min_sum + min(A(i),B(i));
        max_sum = max_sum + max(A(i),B(i));
    end
    SimInd = double(min_sum/max_sum); 
end

function norm = norm(hist,bins)
    total = sum(hist);
    for i = 1:bins
        norm(i) = hist(i)/total;
    end
end

function hist = hist(ip,bins)
    % initialize Histogram of original image
    hist = zeros(1,bins);
    
    % Calculate histogram
    for i = 1:size(ip)       
            hist(ip(i)) = hist(ip(i)) +1;
    end
end
