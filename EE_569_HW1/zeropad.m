% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 28 Jan, 2024

function zeropad = zeropad(img, f_size)
zeropad = zeros(size(img,1)+(f_size-1),size(img,2)+(f_size-1));
% Zeropad for borders
for i=1+(f_size-1)/2 : size(img,1)+(f_size-1)/2
    for j =1+(f_size-1)/2 : size(img,2)+(f_size-1)/2
        zeropad(i,j) = img(i-(f_size-1)/2,j-(f_size-1)/2);
    end
end
end
