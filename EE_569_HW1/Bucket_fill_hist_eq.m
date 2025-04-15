% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 28 Jan, 2024

function buc_eq_img = Bucket_fill_hist_eq(img)

% Finding no. of pixels to go into each bucket
pix_no = (size(img,1)*size(img,2))/256;

buc_eq_img = zeros(size(img,1),size(img,2));
buc_size = 0;
replace = 0;
for k = 0:255
  for i=1:size(img,1)
    for j=1:size(img,2)
        if(img(i,j) == k && buc_size<=pix_no)
            buc_eq_img(i,j) = replace;
            buc_size = buc_size + 1;
        end
        if(buc_size>pix_no)
            buc_size = 0;
            replace = replace+1;
        end
    end
  end
end
  % Histogram after bucket filling technique
histo = zeros(1,256);

% Calculate histogram
for i = 1:size(buc_eq_img,1)
    for j = 1:size(buc_eq_img,2)
        histo(buc_eq_img(i,j)+1) = histo(buc_eq_img(i,j)+1) + 1; 
    end
end

figure;
stem(histo);
xlabel("Pixel intensity");
ylabel("Pixel frequency");
title("Image histogram after bucket filling");
end