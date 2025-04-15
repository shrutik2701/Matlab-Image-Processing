% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 19 Feb 2024

close all;
% Read image
img = readraw("Bird.raw",375,500,0);
figure;
imshow(uint8(img));
title("Original image");
x = size(img,1);
y = size(img,2);

c = zeros(x,y);
m = zeros(x,y);
y_ = zeros(x,y);

out = zeros(x,y,3);

for i=1:x
    for j=1:y
        c(i,j) = double(1 - (img(i,j,1))/255.0);
        m(i,j) = double(1 - (img(i,j,2))/255.0);
        y_(i,j) = double(1 - (img(i,j,3))/255.0);
    end
end

% Each channel Floyd_steinberg
c = Floyd_Steinberg(c,x,y);
m = Floyd_Steinberg(m,x,y);
y_ = Floyd_Steinberg(y_,x,y);
% figure;
% imshow(uint8(y_));

for i=1:x
    for j=1:y
        out(i,j,1) = double(1 - uint8(c(i,j))/255.0)*255;
        out(i,j,2) = double(1 - uint8(m(i,j))/255.0)*255;
        out(i,j,3) = double(1 - uint8(y_(i,j))/255.0)*255;
    end
end

figure;
imshow(uint8(out));
title(' After seperable error diffusion ');




% MBVQ-based Error diffusion

mbvq_img = zeros(x,y,3);
% Calculating MBVQ value
% CMYW=1 / MYGC=2 / RGMY=3 / KRGB=4 / RGBM=5 / CMGB=6
f(:,:,1) = zeropad(img(:,:,1),3);
f(:,:,3) = zeropad(img(:,:,3),3);
f(:,:,2) = zeropad(img(:,:,2),3);

h1 = 1/16.*[0 0 0 ; 0 0 7;3 5 1];
for i = 2:x+1
  if mod(i,2)==0
    for j=2:y+1
        r = f(i,j,1);
        g = f(i,j,2);
        b = f(i,j,3);
        mbvq = MBVQ(r,g,b);
        if mbvq==1
            v = cmyw(r,g,b);
        elseif mbvq == 2
            v= mygc(r,g,b);
        elseif mbvq == 3
            v = rgmy(r,g,b);
        elseif mbvq == 4
            v = krgb(r,g,b);
        elseif mbvq == 5
            v = rgbm(r,g,b);
        else
            v = cmgb(r,g,b);
        end
        % y=7 / m=6 / c=5 / g=3 / r=2 / b=4 / w=1 
        if v==1
            mbvq_img(i-1,j-1,1)=255;
            mbvq_img(i-1,j-1,2)=255;
            mbvq_img(i-1,j-1,3)=255;
        elseif v==2
            mbvq_img(i-1,j-1,1)=255;
            mbvq_img(i-1,j-1,2)=0;
            mbvq_img(i-1,j-1,3)=0;
        elseif v==3
            mbvq_img(i-1,j-1,1)=0;
            mbvq_img(i-1,j-1,2)=255;
            mbvq_img(i-1,j-1,3)=0;
        elseif v==4
            mbvq_img(i-1,j-1,1)=0;
            mbvq_img(i-1,j-1,2)=0;
            mbvq_img(i-1,j-1,3)=255;
        elseif v==5
            mbvq_img(i-1,j-1,1)=0;
            mbvq_img(i-1,j-1,2)=255;
            mbvq_img(i-1,j-1,3)=255;
        elseif v==6
            mbvq_img(i-1,j-1,1)=255;
            mbvq_img(i-1,j-1,2)=0;
            mbvq_img(i-1,j-1,3)=255;
        elseif v==7
            mbvq_img(i-1,j-1,1)=255;
            mbvq_img(i-1,j-1,2)=255;
            mbvq_img(i-1,j-1,3)=0;
        else
            mbvq_img(i-1,j-1,1)=0;
            mbvq_img(i-1,j-1,2)=0;
            mbvq_img(i-1,j-1,3)=0;
        end
        e = f(i,j,1) - mbvq_img(i-1,j-1,1);
        f(i-1:i+1,j-1:j+1,1) = add_error(f(i-1:i+1,j-1:j+1,1), h1,e);
        e = f(i,j,2) - mbvq_img(i-1,j-1,2);
        f(i-1:i+1,j-1:j+1,2) = add_error(f(i-1:i+1,j-1:j+1,2), h1,e);
        e = f(i,j,3) - mbvq_img(i-1,j-1,3);
        f(i-1:i+1,j-1:j+1,3) = add_error(f(i-1:i+1,j-1:j+1,3), h1,e);
    end
  else
     for j=y+1:-1:2
        r = f(i,j,1);
        g = f(i,j,2);
        b = f(i,j,3);
        mbvq = MBVQ(r,g,b);
        if mbvq==1
            v = cmyw(r,g,b);
        elseif mbvq == 2
            v= mygc(r,g,b);
        elseif mbvq == 3
            v = rgmy(r,g,b);
        elseif mbvq == 4
            v = krgb(r,g,b);
        elseif mbvq == 5
            v = rgbm(r,g,b);
        else
            v = cmgb(r,g,b);
        end
        % y=7 / m=6 / c=5 / g=3 / r=2 / b=4 / w=1 
        if v==1
            mbvq_img(i-1,j-1,1)=255;
            mbvq_img(i-1,j-1,2)=255;
            mbvq_img(i-1,j-1,3)=255;
        elseif v==2
            mbvq_img(i-1,j-1,1)=255;
            mbvq_img(i-1,j-1,2)=0;
            mbvq_img(i-1,j-1,3)=0;
        elseif v==3
            mbvq_img(i-1,j-1,1)=0;
            mbvq_img(i-1,j-1,2)=255;
            mbvq_img(i-1,j-1,3)=0;
        elseif v==4
            mbvq_img(i-1,j-1,1)=0;
            mbvq_img(i-1,j-1,2)=0;
            mbvq_img(i-1,j-1,3)=255;
        elseif v==5
            mbvq_img(i-1,j-1,1)=0;
            mbvq_img(i-1,j-1,2)=255;
            mbvq_img(i-1,j-1,3)=255;
        elseif v==6
            mbvq_img(i-1,j-1,1)=255;
            mbvq_img(i-1,j-1,2)=0;
            mbvq_img(i-1,j-1,3)=255;
        elseif v==7
            mbvq_img(i-1,j-1,1)=255;
            mbvq_img(i-1,j-1,2)=255;
            mbvq_img(i-1,j-1,3)=0;
        else
            mbvq_img(i-1,j-1,1)=0;
            mbvq_img(i-1,j-1,2)=0;
            mbvq_img(i-1,j-1,3)=0;
        end
        e = f(i,j,1) - mbvq_img(i-1,j-1,1);
        f(i-1:i+1,j-1:j+1,1) = add_error(f(i-1:i+1,j-1:j+1,1), h1,e);
        e = f(i,j,2) - mbvq_img(i-1,j-1,2);
        f(i-1:i+1,j-1:j+1,2) = add_error(f(i-1:i+1,j-1:j+1,2), h1,e);
        e = f(i,j,3) - mbvq_img(i-1,j-1,3);
        f(i-1:i+1,j-1:j+1,3) = add_error(f(i-1:i+1,j-1:j+1,3), h1,e);
     end
   end
end
figure;
imshow(uint8(mbvq_img));
title(' After MBVQ based diffusion ');


function mbvq = MBVQ(r,g,b)
% CMYW=1 / MYGC=2 / RGMY=3 / KRGB=4 / RGBM=5 / CMGB=6
if (r+g)>255
    if g+b > 255
        if r+g+b >510
            mbvq= 1;
        else
            mbvq= 2;
        end
    else
        mbvq= 3;
    end
else
    if g+b<=255
        if r+g+b<=255
            mbvq= 4;
        else
            mbvq = 5;
        end
    else
        mbvq= 6;
    end
end
end

function cmgb = cmgb(r,g,b)
% m=6 / c=5 / g=3 / b=4
if b>127
    if r>127
        if g>r
            cmgb = 5;
        else
            cmgb = 6;
        end
    else
        if g>127
            cmgb = 5;
        else
            cmgb = 4;
        end
    end
else
    if r>127
        if r-g+b>127
            cmgb = 6;
        else
            cmgb = 3;
        end
    else
        if g>b
            cmgb = 3;
        else
            cmgb = 4;
        end
    end
end
end

function cmyw = cmyw(r,g,b)
% m=6 / c=5 / y=7 / w=1
cmyw = 1;
if b<128
    if b<=r
        if b<=g
            cmyw = 7;
        end
    end
end
if g<128
    if g<=b
        if g<=r
            cmyw=6;
        end
    end
end
if r<128
    if r<=b
        if r<=g
            cmyw = 5;
        end
    end
end
end

function mygc = mygc(r,g,b)
% m=6 / c=5 / y=7 / g=3
mygc=6;
if g>=b
    if r>=b
        if r>=128
            mygc = 7;
        else
            mygc=3;
        end
    end
end
if g>=r
    if b>=r
        if b>127
            mygc=5;
        else
            mygc=3;
        end
    end
end
end

function rgmy = rgmy(r,g,b)
if b>128
    if r>128
        if b>=g
            rgmy=6;
        else
            rgmy=7;
        end
    else
        if g>b+r
            rgmy=3;
        else
            rgmy=6;
        end
    end
else
    if r>128
        if g>128
            rgmy=7;
        else 
            rgmy=2;
        end
    else
        if r>=g
            rgmy=2;
        else 
            rgmy=3;
        end
    end
end
end

function krgb = krgb(r,g,b)
krgb=8;
if b>128
    if b>=r
        if b>=g
            krgb=4;
        end
    end
end
if g>128
    if g>=b
        if g>=r
            krgb=3;
        end
    end
end
if r>128
    if r>=b
        if r>=g
            krgb=2;
        end
    end
end
end

function rgbm = rgbm(r,g,b)
rgbm=3;
if r>g
    if r>=b
        if b<128
            rgbm=2;
        else 
            rgbm=6;
        end
    end
end
if b>g
    if b>=r
        if r<128
            rgbm=4;
        else
            rgbm=6;
        end
    end
end
end