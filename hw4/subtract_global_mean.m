% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 29 Mar, 2024

function r_i_img = subtract_global_mean(org,r,c)
r_i_img = zeros(r,c);
avg = sum(org(:))/r/c;
r_i_img(:,:) = org - avg;
end