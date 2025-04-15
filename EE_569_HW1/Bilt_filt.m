% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 28 Jan, 2024

function [psnr,y] = Bilt_filt(ip, filter_size, sigma_c, sigma_s)

y = zeros(size(ip,1), size(ip,2));
img = zeros(size(ip,1)+(filter_size-1), size(ip,2)+(filter_size-1));

% Zeropad for borders
for i=1+(filter_size-1)/2 : size(ip,1)+(filter_size-1)/2
    for j =1+(filter_size-1)/2 : size(ip,2)+(filter_size-1)/2
        img(i,j) = ip(i-(filter_size-1)/2,j-(filter_size-1)/2);
    end
end
mse =0;
for i=1+(filter_size-1)/2:size(ip,1)+(filter_size-1)/2
    for j =1+(filter_size-1)/2:size(ip,2)+(filter_size-1)/2
        w_tot = 0;
        y_num = 0;
        for k=i-(filter_size-1)/2 : i+(filter_size-1)/2
            for l = j-(filter_size-1)/2 : j+(filter_size-1)/2
                w = exp(-((i-k)^2+(j-l)^2)/(2*sigma_c^2)-((img(i,j)-img(k,l)).^2/(2*sigma_s^2)));
                w_tot = w_tot+w;
                y_num = y_num+ img(k,l)*w ;
            end
        end
        y(i-(filter_size-1)/2,j-(filter_size-1)/2) = y_num/w_tot;
        mse = mse+ ((y(i-(filter_size-1)/2,j-(filter_size-1)/2)- img(i,j))^2)/(512*768);    
    end
end
psnr= 10*log10(255^2/mse);
end
