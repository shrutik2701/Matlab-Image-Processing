% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 


% Dithering

close all;
% Read image
img = readraw("LightHouse.raw",500,750,1);
figure;
imshow(uint8(img));
title("Original image");
x = size(img,1);
y = size(img,2);

% Fixed Thresholding
img_fix_thresh = zeros(x,y);
T = 128; % Threshold value
for i=1: x
    for j=1:y
        if uint8(img(i,j))>=T
            img_fix_thresh(i,j) = 255;
        end
    end
end
figure;
imshow(uint8(img_fix_thresh));
title('After fixed thresholding');

% Random Thresholding
rand_var_mat = 255*rand(x,y);
img_rand_thresh = zeros(x,y);
for i=1: x
    for j=1:y
        if img(i,j) >= rand_var_mat(i,j)
            img_rand_thresh(i,j) = 255;
        end
    end
end
figure;
imshow(uint8(img_rand_thresh));
title('After random thresholding');

% Dithering matrix
I2 = [1 2; 3 0]; 
I4 = Dithering_mat(I2,4);
I8 = Dithering_mat(I4,8);
I16 = Dithering_mat(I8,16);
I32 = Dithering_mat(I16,32);

% Threshold matrix
I2_t = Dithering_thresh(I2,2);
I8_t = Dithering_thresh(I8,8);
I32_t = Dithering_thresh(I32,32);
halftone_2 = zeros(x,y);
halftone_8 = zeros(x,y);
halftone_32 = zeros(x,y);
 
for i=0: x-1
    for j=0:y-1
        if img(i+1,j+1) >= uint8(I2_t(mod(i,2)+1,mod(j,2)+1))
            halftone_2(i+1,j+1) = 255;
        end
        if img(i+1,j+1) >= uint8(I8_t(mod(i,8)+1,mod(j,8)+1))
            halftone_8(i+1,j+1) = 255;
        end
        if img(i+1,j+1) >= uint8(I32_t(mod(i,32)+1,mod(j,32)+1))
            halftone_32(i+1,j+1) = 255;
        end
    end
end
figure;
imshow(uint8(halftone_2));
title('After I2 thresholding');
figure;
imshow(uint8(halftone_8));
title('After I8 thresholding');
figure;
imshow(uint8(halftone_32));
title('After I32 thresholding');


% Error diffusion
% FLOYD STEINBERG
h1 = 1/16.*[0 0 0 ; 0 0 7;3 5 1];
f = zeropad(img,3);
b = zeros (x,y);

for i=2:x+1
    if(mod(i,2)==0)
        for j=2:y+1
            if(f(i,j)>T) 
                b(i-1,j-1) = 255;
            end
            e= f(i,j) - b(i-1,j-1);
            f(i-1:i+1,j-1:j+1) = add_error(f(i-1:i+1,j-1:j+1), h1,e);
        end
    else
        for j=y+1:-1:2
            if(f(i,j)>T) 
                b(i-1,j-1) = 255;
            end
            e= f(i,j) - b(i-1,j-1);
            f(i-1:i+1,j-1:j+1) = add_error(f(i-1:i+1,j-1:j+1), h1,e);
        end
    end
end

figure;
imshow(uint8(b));
title('Error diffusion - Floyd Steinberg');

% JJN
f = zeropad(img,5);
b = zeros (x,y);
h2 = 1/48.*[0 0 0 0 0; 0 0 0 0 0 ; 0 0 0 7 5;3 5 7 5 3; 1 3 5 3 1];

for i=3:x+2
    if(mod(i,2)==1)
        for j=3:y+2
            if(f(i,j)>T) 
                b(i-2,j-2) = 255;
            end
            e= f(i,j) - b(i-2,j-2);
            f(i-2:i+2,j-2:j+2) = add_error(f(i-2:i+2,j-2:j+2), h2,e);
        end
    else
        for j=y+2:-1:3
            if(f(i,j)>T) 
                b(i-2,j-2) = 255;
            end
            e= f(i,j) - b(i-2,j-2);
            f(i-2:i+2,j-2:j+2) = add_error(f(i-2:i+2,j-2:j+2), h2,e);
        end
    end
end

figure;
imshow(uint8(b));
title('Error diffusion - JJN');

% Stucki
f = zeropad(img,5);
b = zeros (x,y);
h3 = 1/42.*[0 0 0 0 0; 0 0 0 0 0 ; 0 0 0 8 4;2 4 8 4 2; 1 2 4 2 1];

for i=3:x+2
    if(mod(i,2)==1)
        for j=3:y+2
            if(f(i,j)>T) 
                b(i-2,j-2) = 255;
            end
            e= f(i,j) - b(i-2,j-2);
            f(i-2:i+2,j-2:j+2) = add_error(f(i-2:i+2,j-2:j+2), h3,e);
        end
    else
        for j=y+2:-1:3
            if(f(i,j)>T) 
                b(i-2,j-2) = 255;
            end
            e= f(i,j) - b(i-2,j-2);
            f(i-2:i+2,j-2:j+2) = add_error(f(i-2:i+2,j-2:j+2), h3,e);
        end
    end
end

figure;
imshow(uint8(b));
title('Error diffusion - Stucki');


% functions

function Dithering_mat = Dithering_mat(initial, N)
Dithering_mat = zeros(N,N);
for i=0:N-1
    for j=0:N-1
        temp = 4*initial(mod(i,N/2)+1,mod(j,N/2)+1);
        if (i<N/2 && j<N/2)
            Dithering_mat(i+1,j+1) = temp +1;
        elseif (i<N/2 && j>=N/2)
             Dithering_mat(i+1,j+1) = temp +2;
        elseif (i>=N/2 && j<N/2)
                Dithering_mat(i+1,j+1) = temp +3;
        else
            Dithering_mat(i+1,j+1) = temp;
        end
    end
end

end

function Dit_thresh = Dithering_thresh(I,N)
Dit_thresh = zeros(N,N);
for i=1:N
   for j=1:N
    Dit_thresh(i,j) = (I(i,j) + 0.5)/N/N * 255;
   end
end

end

function add_error = add_error(f,h,e)
i = size(h,1);
j = size(h,2);
add_error = zeros(i,j);
for k=1:i
   for l = 1:j
       add_error(k,l) = f(k,l)+h(k,l)*e;
   end
end
end