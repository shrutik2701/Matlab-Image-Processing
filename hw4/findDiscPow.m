% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 29 Mar, 2024

function disc_pow = findDiscPow(features)
    disc_avg_1 = mean(features(1:9,:));
    disc_avg_2 = mean(features(10:18,:));
    disc_avg_3 = mean(features(19:27,:));
    disc_avg_4 = mean(features(28:36,:));

    intra_blanket = sum((features(1:9,:)-disc_avg_1).^2);
    intra_brick = sum((features(10:18,:)-disc_avg_2).^2);
    intra_grass = sum((features(19:27,:)-disc_avg_3).^2);
    intra_rice = sum((features(28:36,:)-disc_avg_4).^2);

    intra_class_variation = intra_blanket+intra_brick+intra_grass+intra_rice;

    global_avg = mean(features);
    
    inter_class_variation = (8*(disc_avg_1-global_avg).^2)+(8*(disc_avg_2-global_avg).^2)+(8*(disc_avg_3-global_avg).^2)+(8*(disc_avg_4-global_avg).^2);

    disc_pow = intra_class_variation./inter_class_variation;
end









% avg = sum(feature_vector(:))/size(feature_vector,1)/size(feature_vector,2);
% classwise_avg = zeros(4,1);
% c = mean(feature_vector(1:9,:));
% classwise_avg(1) = c;
% c = mean(feature_vector(10:18,:));
% classwise_avg(2) = c;
% c = mean(feature_vector(19:27,:));
% classwise_avg(3) = c;
% c = mean(feature_vector(28:36,:));
% classwise_avg(4) = c;
% 
% % Finding intra variety
% intra_var = 0;
% inter_var = 0;
% for i=1:4
%     intra_var = intra_var + sum(feature_vector(i*9-9:i*9,:)-classwise_avg(i)).^2;
%     inter_var = inter_var + sum(9*((classwise_avg(i) - avg).^2));
% end
% 
% disc_pow = intra_var/inter_var;
% end