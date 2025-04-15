% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 28 Jan, 2024

function ret_img = Trans_func_hist_eq(img)

% Histogram of org image
histo = zeros(1,256);

% Calculate histogram
for i = 1:size(img,1)
    for j = 1:size(img,2)
        histo(img(i,j)+1) = histo(img(i,j)+1) + 1; 
    end
end

figure;
stem(histo);
xlabel("Pixel intensity");
ylabel("Pixel frequency");
title("Original image histogram");

% Normalizing histogram ( Calculate probability of each pixel = occurance/totpixels ) & calculating cummulative probab
norm_hist = zeros(1,256);
cumm_prob = zeros(1,256);

for i=1:256
    norm_hist(i) = histo(i)/(340*596);             % normalize hist
    if(i~=1)
        cumm_prob(i) = cumm_prob(i-1) + norm_hist(i); % cumulative prob
    else
        cumm_prob(i) = norm_hist(i); % cumulative prob
    end
end

figure;
plot(floor(cumm_prob*255));
title("Transfer function of image");

ret_img = (floor(cumm_prob(img+1)*255));

end