% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 28 Jan, 2024

function [psnr,y] = gauss_filt(img,filter_size, sigma)
psnr=0;

mse=0;
y1 = zeropad(img, filter_size);
y = zeros(size(img,1),size(img,2));

for i=1+(filter_size-1)/2:size(img,1)+(filter_size-1)/2
    for j =1+(filter_size-1)/2:size(img,2)+(filter_size-1)/2
        w_tot = 0;
        y_num = 0;
        for k=i-(filter_size-1)/2 : i+(filter_size-1)/2
            for l = j-(filter_size-1)/2 : j+(filter_size-1)/2
                w = 1/(sqrt(2*pi)*sigma) *exp(-((i-k)^2+(j-l)^2)/(2*sigma^2));
                w_tot = w_tot+w;
                y_num = y_num+ y1(k,l)*w ;
            end
        end
        y(i-(filter_size-1)/2,j-(filter_size-1)/2) = y_num/w_tot;
        mse = mse+ ((y(i-(filter_size-1)/2,j-(filter_size-1)/2)- img(i-(filter_size-1)/2,j-(filter_size-1)/2))^2)/(512*768);    
    end
end

psnr= 10*log10(255^2/mse);
end


