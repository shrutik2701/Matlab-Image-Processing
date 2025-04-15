% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 28 Jan, 2024

function [psnr,y] = uni_filt(img,filt_size)
psnr=0;
U_ker = U_Kernel(filt_size);
mse=0;
y1 = zeropad(img, filt_size);
y = zeros(size(img,1),size(img,2));

for i=1 : size(img,1)
    for j =1 : size(img,2)
        temp = y1(i:i+(filt_size-1),j:j+(filt_size-1));
        y(i,j) = conv_img(U_ker, temp);
        mse = mse+ ((y(i,j)- img(i,j))^2)/(512*768);
    end
end
psnr= 10*log10(255^2/mse);

end

function U_kernel = U_Kernel(size)
    U_kernel = ones(size) / size^2;      % Normalize the kernel
end
