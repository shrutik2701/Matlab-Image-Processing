% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 29 Mar, 2024

clear all; 
close all;

Trainpath = dir('C:\Users\shrut\OneDrive\Documents\Matlab_new\EE569_2024Spring_HW4_materials\train\*.raw');
len_train = length(Trainpath);
label= [0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3];
r = 128; c = 128;
for i =1:9 % len_train
    img_1 = readraw( Trainpath(i).name ,r,c,1);
    img_new_1 = subtract_global_mean(img_1,r,c);

    img_2 = readraw( Trainpath(i+9).name ,r,c,1);
    img_new_2 = subtract_global_mean(img_2,r,c);

    img_3 = readraw( Trainpath(i+18).name ,r,c,1);
    img_new_3 = subtract_global_mean(img_3,r,c);

    img_4 = readraw( Trainpath(i+27).name ,r,c,1);
    img_new_4 = subtract_global_mean(img_4,r,c);

    feat_1(i,:) = generate_features(img_new_1,r,c);
    feat_2(i,:) = generate_features(img_new_2,r,c);
    feat_3(i,:) = generate_features(img_new_3,r,c);
    feat_4(i,:) = generate_features(img_new_4,r,c);

end
feature_vector = [feat_1; feat_2; feat_3; feat_4];

% Finding Discriminant Power
disc_power = findDiscPow(feature_vector);

% Apply PCA to training features
[coeff, s, vc] = pca(feature_vector);
features_pca = feature_vector * coeff(:,1:3);
%features_pca = features_pca(:,1:3);

% Visualizing features after PCA
scatter3(features_pca(1:9,1),features_pca(1:9,2),features_pca(1:9,3));
hold on
scatter3(features_pca(10:18,1),features_pca(10:18,2),features_pca(10:18,3));
hold on
scatter3(features_pca(19:27,1),features_pca(19:27,2),features_pca(19:27,3));
hold on
scatter3(features_pca(28:36,1),features_pca(28:36,2),features_pca(28:36,3));
hold on
legend('Blanket','Brick','Grass','Stone');
xlabel('1st Principal Component');
ylabel('2nd Principal Component');
zlabel('3rd Principal Component');

% Testinggg
Testpath = dir('C:\Users\shrut\OneDrive\Documents\Matlab_new\EE569_2024Spring_HW4_materials\test\*.raw');
for i =1:12 % len_train
    img_1 = readraw( Testpath(i).name ,r,c,1);
    img_new_1 = subtract_global_mean(img_1,r,c);

    feat_test_vect(i,:) = generate_features(img_new_1,r,c);
end

% % Finding Discriminant Power
%disc_power_test = findDiscPow(feat_test_vect);

% % Apply PCA to training features
%[coeff, ~, ~] = pca(feat_test_vect);
features_pca_test = feat_test_vect * coeff(:,1:3);


test_predictions = zeros(12,1);

% 0:Blanket 1:Brick 2:Grass 3:Stone
corr_test = [1 1 0 2 0 3 0 3 2 2 3 1 ];
%corr_test=corr_test+1;
tp=0;

% Mahalanobis Distance
for i=1:12
    m_disti_1 = mahal(features_pca_test(i,:),features_pca(1:9,:));
    m_disti_2 = mahal(features_pca_test(i,:),features_pca(10:18,:));
    m_disti_3 = mahal(features_pca_test(i,:),features_pca(19:27,:));
    m_disti_4 = mahal(features_pca_test(i,:),features_pca(28:36,:));
    if m_disti_1<m_disti_2 && m_disti_1<m_disti_3 && m_disti_1<m_disti_4
        test_predictions(i) = 0;
    elseif m_disti_2<m_disti_1 && m_disti_2<m_disti_3 && m_disti_2<m_disti_4
        test_predictions(i) = 1;
    elseif m_disti_3<m_disti_1 && m_disti_3<m_disti_2 && m_disti_3<m_disti_4
        test_predictions(i) = 2;
    else
        test_predictions(i) = 3;
    end
    if corr_test(i)==test_predictions(i)
        tp=tp+1;
    end
end

acc = tp/12;
err_rate = 1-acc;

% 1b

% K-means Clustering
rng(1)
tp25 = 0; tp3 =0;
[idsss, centroid] = kmeans(feature_vector,4, 'Distance', 'cityblock', 'MaxIter', 10000,'OnlinePhase','off','Start','cluster','Replicates',5);
k25 = knnsearch(centroid,feat_test_vect);

[idss, centroid2] = kmeans(features_pca,4, 'Distance', 'cityblock', 'MaxIter', 10000,'OnlinePhase','off','Start','uniform','Replicates',5);
k3 = knnsearch(centroid2,features_pca_test);
for i=1:12
    if  corr_test(i)+1 == k25(i)
        tp25=tp25+1;
    end
    if corr_test(i)+1 == k3(i)
        tp3=tp3+1;
    end
end
acc_k_25 = tp25/12;
acc_k_3 = tp3/12;
err_rate_k_25 = 1-acc_k_25;
err_rate_k_3 = 1-acc_k_3;

% SVM 
t = templateSVM('Standardize',true,'KernelFunction','gaussian');
SVM25 = fitcecoc(feature_vector,label','Learners',t);
tp_s_25 = 0; tp_s_3 = 0;
s25 = predict(SVM25,feat_test_vect);
SVM3 = fitcecoc(features_pca,label','Learners',t);
s3 = predict(SVM3,features_pca_test);
for i=1:12
    if  corr_test(i) == s25(i)
        tp_s_25= tp_s_25+1;
    end
    if corr_test(i) == s3(i)
        tp_s_3=tp_s_3+1;
    end
end
acc_s_25 = tp_s_25/12;
acc_s_3 = tp_s_3/12;
err_rate_s_25 = 1-acc_s_25;
err_rate_s_3 = 1-acc_s_3;

