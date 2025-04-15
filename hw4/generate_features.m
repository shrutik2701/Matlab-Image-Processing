% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 29 Mar, 2024

function feat = generate_features(img,r,c)
k=1;
feat = zeros(1,25);
laws_filters = [ [1 4 6 4 1]; [-1 -2 0 2 1]; [-1 0 2 0 -1]; [-1 2 0 -2 1]; [1 -4 6 -4 1] ];
for i=1:5
    for j = 1:5
        now_filt = laws_filters(i,:)'*laws_filters(j,:);
        op_img = conv_img_new(img, now_filt);
        feat(k) = find_avg_energy(op_img,r,c);
        k=k+1;
        
    end
end
end

function op = conv_img_new(img1,img2)
img1 = zeropad(img1,5);
r = size(img1,1);
c = size(img1,2);
op = zeros(128,128);
for i = 3:r-2
    for j = 3:c-2
        op(i-2,j-2) = conv_img(img1(i-2:i+2,j-2:j+2),img2);
    end
end
end

function avg = find_avg_energy(op_img,r,c)
avg =0;
for i=1:r
    for j = 1:c
        avg = avg + op_img(i,j)*op_img(i,j)/r/c;
    end
end
end


