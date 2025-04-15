% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 10 Feb 2024
% Problem 3a: Thinning


close all;
img = readraw('jar.raw',252,252,1);
row = size(img,1);
col =  size(img,2);

figure;
imshow(uint8(img));
title('Original image');


% conditional Patterns
% s_1_ne = [0,0,1; 0,1,0; 0,0,0];
% s_1_nw = [1 0 0; 0,1,0;0,0,0]; % v wrong
% s_1_sw = [0,0,0; 0,1,0; 1,0,0];
% s_1_se = [0,0,0; 0,1,0; 0,0,1];
% s_2_e = [0,0,0; 0,1,1; 0,0,0];
% s_2_n = [0,1,0; 0,1,0; 0,0,0];
% s_2_w = [0,0,0;1,1,0;0,0,0];
% s_2_s = [0,0,0;0,1,0;0,1,0];
% s_3_e_ne = [0,0,1;0,1,1;0,0,0];
% s_3_ne_n = [0,1,1;0,1,0;0,0,0];
% s_3_n_nw = [1,1,0;0,1,0;0,0,0];
% s_3_nw_w = [1,0,0;1,1,0;0,0,0];
% s_3_w_sw = [0,0,0;1,1,0;1,0,0];
% s_3_sw_s = [0,0,0;0,1,0;1,1,0];
% s_3_s_se = [0,0,0;0,1,0;0,1,1];
% s_3_se_e = [0,0,0;0,1,1;0,0,1];
tk_4_ne = [0,1,0; 0,1,1; 0,0,0];%
tk_4_nw = [0,1,0; 1,1,0; 0,0,0];
tk_4_ws = [0,0,0; 1,1,0; 0,1,0];
tk_4_es = [0,0,0; 0,1,1; 0,1,0];

stk_4_1 = [0,0,1; 0,1,1; 0,0,1];
stk_4_2 = [1,1,1; 0,1,0; 0,0,0];
stk_4_3 = [1,0,0; 1,1,0; 1,0,0];
stk_4_4 = [0,0,0; 0,1,0; 1,1,1];
st_5_1 = [1,1,0; 0,1,1; 0,0,0];
st_5_2 = [0,1,0; 0,1,1; 0,0,1];
st_5_3 = [0,1,1; 1,1,0; 0,0,0];
st_5_4 = [0,0,1; 0,1,1; 0,1,0];
st_5_5 = [0,1,1; 0,1,1; 0,0,0];
st_5_6 = [1,1,0; 1,1,0; 0,0,0];
st_5_7 = [0,0,0; 1,1,0; 1,1,0];
st_5_8 = [0,0,0; 0,1,1; 0,1,1];

st_6_1 = [1,1,0; 0,1,1; 0,0,1];
st_6_2 = [0,1,1; 1,1,0; 1,0,0];

stk_6_1 = [1,1,1;0,1,1;0,0,0];
stk_6_2 = [0,1,1;0,1,1;0,0,1];
stk_6_3 = [1,1,1;1,1,0;0,0,0];
stk_6_4 = [1,1,0;1,1,0;1,0,0];
stk_6_5 = [1,0,0;1,1,0;1,1,0];
stk_6_6 = [0,0,0;1,1,0;1,1,1];
stk_6_7 = [0,0,0;0,1,1;1,1,1];
stk_6_8 = [0,0,1;0,1,1;0,1,1];
stk_7_1 = [1,1,1;0,1,1;0,0,1];
stk_7_2 = [1,1,1;1,1,0;1,0,0];
stk_7_3 = [1,0,0;1,1,0;1,1,1];
stk_7_4 = [0,0,1;0,1,1;1,1,1];
stk_8_1 = [0,1,1;0,1,1;0,1,1];
stk_8_2 = [1,1,1;1,1,1;0,0,0];
stk_8_3 = [1,1,0;1,1,0;1,1,0];
stk_8_4 = [0,0,0;1,1,1;1,1,1];
stk_9_1 = [1,1,1;0,1,1;0,1,1];
stk_9_2 = [0,1,1;0,1,1;1,1,1];
stk_9_3 = [1,1,1;1,1,1;1,0,0];
stk_9_4 = [1,1,1;1,1,1;0,0,1];
stk_9_5 = [1,1,1;1,1,0;1,1,0];
stk_9_6 = [1,1,0;1,1,0;1,1,1];
stk_9_7 = [1,0,0;1,1,1;1,1,1];
stk_9_8 = [0,0,1;1,1,1;1,1,1];
stk_10_1 = [1,1,1;0,1,1;1,1,1];
stk_10_2 = [1,1,1;1,1,1;1,0,1];
stk_10_3 = [1,1,1;1,1,0;1,1,1];
stk_10_4 = [1,0,1;1,1,1;1,1,1];
% k_11_1 = [1,1,1;1,1,1;0,1,1];
% k_11_2 = [1,1,1;1,1,1;1,1,0];
% k_11_3 = [1,1,0;1,1,1;1,1,1];
% k_11_4 = [0,1,1;1,1,1;1,1,1];

% unconditional mat
db_1 = [5 1 0; 0 1 1; 1 0 5 ];
db_2 = [0 1 5; 1 1 0;5 0 1];
db_3 = [5 0 1; 1 1 0; 5 0 1];
db_4 = [1 0 5; 0 1 1; 5 1 0];

vb_3_1 = [ 1 1 1; 5 1 5; 1 5 1]; %7
vb_3_2 = [ 1 1 0; 5 1 5; 1 5 1]; %6
vb_3_3 = [ 0 0 0; 5 1 5; 1 5 1]; %0   % THISSSSS
vb_3_4 = [ 0 1 1; 5 1 5; 1 5 1]; %3
vb_3_5 = [0 1 0; 5 1 5; 1 5 1]; %2
vb_3_6 = [1 0 1; 5 1 5; 1 5 1]; %5
vb_3_7 = [1 0 0; 5 1 5; 1 5 1]; %4    % THISSSSS
vb_3_8 = [ 0 0 1; 5 1 5; 1 5 1]; %1
vb_4_1 = [0 5 1; 0 1 5; 0 5 1];    % THISSSSS
vb_4_2 = [0 5 1; 0 1 5; 1 5 1];   % THISSSSS
vb_4_3 = [0 5 1; 1 1 5; 0 5 1];
vb_4_4 = [0 5 1; 1 1 5; 1 5 1];
vb_4_5 = [1 5 1; 0 1 5; 0 5 1];
vb_4_6 = [1 5 1; 0 1 5; 1 5 1];
vb_4_7 = [1 5 1; 1 1 5; 0 5 1];
vb_4_8 = [1 5 1; 1 1 5; 1 5 1];
vb_1_1 = [1 5 1; 5 1 5; 0 0 0];    % THISSSSS
vb_1_2 = [1 5 1; 5 1 5; 0 0 1];   % THISSSSS
vb_1_3 = [1 5 1; 5 1 5; 0 1 0];
vb_1_4 = [1 5 1; 5 1 5; 0 1 1];
vb_1_5 = [1 5 1; 5 1 5; 1 0 0];
vb_1_6 = [1 5 1; 5 1 5; 1 0 1];
vb_1_7 = [1 5 1; 5 1 5; 1 1 0];
vb_1_8 = [1 5 1; 5 1 5; 1 1 1];
vb_2_1 = [1 5 0; 5 1 0; 1 5 0];   % THISSSSS
vb_2_2 = [1 5 0; 5 1 0; 1 5 1];
vb_2_3 = [1 5 0; 5 1 1; 1 5 0];
vb_2_4 = [1 5 0; 5 1 1; 1 5 1];
vb_2_5 = [1 5 1; 5 1 0; 1 5 0];   % THISSSSS
vb_2_6 = [1 5 1; 5 1 0; 1 5 1];
vb_2_7 = [1 5 1; 5 1 1; 1 5 0];
vb_2_8 = [1 5 1; 5 1 1; 1 5 1];

spur_1 = [0,0,1;0,1,0;0,0,0];
spur_2 = [1,0,0;0,1,0;0,0,0];
s_4_con_1 = [0,0,0;0,1,0;0,1,0];
s_4_con_2 = [0,0,0;0,1,1;0,0,0];

L_1 = [0,0,1;0,1,1;0,0,0];
L_2 = [0,1,1;0,1,0;0,0,0];
L_3 = [1,1,0;0,1,0;0,0,0];
L_4 = [1,0,0;1,1,0;0,0,0];
L_5 = [0,0,0;1,1,0;1,0,0];
L_6 = [0,0,0;0,1,0;1,1,0];
L_7 = [0,0,0;0,1,0;0,1,1];
L_8 = [0,0,0;0,1,1;0,0,1];

con_off_1 = [0,1,1;1,1,0;0,0,0];
con_off_2 = [1,1,0;0,1,1;0,0,0];
con_off_3 = [0,1,0;0,1,1;0,0,1];
con_off_4 = [0,0,1;0,1,1;0,1,0];

sp_co_cl_1_1 = [0 0 1; 0 1 0; 1 0 0]; % THISSSSS
sp_co_cl_1_2 = [0 0 1; 0 1 1; 1 0 0];%
sp_co_cl_1_3 = [0 1 1; 0 1 0; 1 0 0];%
sp_co_cl_1_4 = [0 1 1; 0 1 1; 1 0 0];%
% sp_co_cl_2_1 = [1 0 0; 0 1 0; 0 0 1]; - repeated
sp_co_cl_2_2 = [1 0 0; 1 1 0; 0 0 1];%
sp_co_cl_2_3 = [1 1 0; 0 1 0; 0 0 1];%
sp_co_cl_2_4 = [1 1 0; 1 1 0; 0 0 1];%
% sp_co_cl_3_1 = [0 0 1; 0 1 0; 1 0 0]; - repeated
sp_co_cl_3_2 = [0 0 1; 0 1 0; 1 1 0];%
sp_co_cl_3_3 = [0 0 1; 1 1 0; 1 0 0];%
sp_co_cl_3_4 = [0 0 1; 1 1 0; 1 1 0];%
sp_co_cl_4_1 = [1 0 0; 0 1 0; 0 0 1];   % THISSSSS
sp_co_cl_4_2 = [1 0 0; 0 1 0; 0 1 1];%
sp_co_cl_4_3 = [1 0 0; 0 1 1; 0 0 1];%
sp_co_cl_4_4 = [1 0 0; 0 1 1; 0 1 1];%




cor_clu_1 = [1 1 5; 1 1 5; 5 5 5];

tb_1 = [5 1 0; 1 1 1; 5 0 0];
tb_2 = [0 1 5; 1 1 1; 0 0 5];
tb_3 = [0 0 5; 1 1 1; 0 1 5];
tb_4 = [5 0 0; 1 1 1; 5 1 0];
tb_5 = [5 1 5; 1 1 0; 0 1 0];
tb_6 = [0 1 0; 1 1 0; 5 1 5];
tb_7 = [0 1 0; 0 1 1; 5 1 5];
tb_8 = [5 1 5;  0 1 1; 0 1 0];




% Binarization
F_max = max(max(img));
for i=1:row
    for j=1:col
        if img(i,j)>0.5*F_max
            img(i,j)=1;
        else
            img(i,j)=0;
        end
    end
end

% Padding
pad_img = zeros(row+2,col+2);
pad_img(2:row+1, 2:col+1) = img;

% Intermediate image
M = zeros(row,col);
out = img;
figure;
imshow(uint8(out*255));
title('Output image starting pt');
for l=1:50
 if l~=1 
     pad_img(2:row+1, 2:col+1) = out; 
     M = zeros(row,col);
 end
 for i=2:row+1
    for j=2:col+1
        c = checkmat(pad_img(i-1:i+1,j-1:j+1), tk_4_ne) || checkmat(pad_img(i-1:i+1,j-1:j+1), tk_4_nw) || checkmat(pad_img(i-1:i+1,j-1:j+1),tk_4_ws) || checkmat(pad_img(i-1:i+1,j-1:j+1), tk_4_es) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_4_1) || checkmat(pad_img(i-1:i+1,j-1:j+1), stk_4_2) || checkmat(pad_img(i-1:i+1,j-1:j+1), stk_4_3) || checkmat(pad_img(i-1:i+1,j-1:j+1), stk_4_4) || checkmat(pad_img(i-1:i+1,j-1:j+1), st_5_1) || checkmat(pad_img(i-1:i+1,j-1:j+1),st_5_2) || checkmat(pad_img(i-1:i+1,j-1:j+1), st_5_3) || checkmat(pad_img(i-1:i+1,j-1:j+1), st_5_4) || checkmat(pad_img(i-1:i+1,j-1:j+1), st_5_5) || checkmat(pad_img(i-1:i+1,j-1:j+1), st_5_6) || checkmat(pad_img(i-1:i+1,j-1:j+1), st_5_7) || checkmat(pad_img(i-1:i+1,j-1:j+1), st_5_8) || checkmat(pad_img(i-1:i+1,j-1:j+1),st_6_1) || checkmat(pad_img(i-1:i+1,j-1:j+1) ,st_6_2) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_6_1) || checkmat(pad_img(i-1:i+1,j-1:j+1), stk_6_2) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_6_3) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_6_4) || checkmat(pad_img(i-1:i+1,j-1:j+1), stk_6_5) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_6_6)  || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_6_7) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_6_8) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_7_1) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_7_2) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_7_3) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_7_4) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_8_1) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_8_2) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_8_3) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_8_4) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_9_1) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_9_2) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_9_3) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_9_4) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_9_5) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_9_6) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_9_7) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_9_8) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_10_1) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_10_2) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_10_3) || checkmat(pad_img(i-1:i+1,j-1:j+1),stk_10_4);
        if ( c )
            M(i-1,j-1) = 1;
        end
    end
end
% figure;
% imshow(uint8(M*255));
% title('Intermediate image');

pad_img_2 = zeros(row+2,col+2);
pad_img_2(2:row+1,2:col+1) = M;
% out = zeros(row,col);
for i=2:row+1
    for j=2:col+1
        c = uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),tb_1) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),tb_2) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  tb_3) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  tb_4) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  tb_5) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  tb_6) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), tb_7) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), tb_8) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), cor_clu_1) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  sp_co_cl_4_4) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  sp_co_cl_4_3) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  sp_co_cl_4_2) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), sp_co_cl_4_1) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  sp_co_cl_3_4) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  sp_co_cl_3_3) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  sp_co_cl_3_2) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  sp_co_cl_2_4) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  sp_co_cl_2_3) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  sp_co_cl_2_2) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  sp_co_cl_1_4) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  sp_co_cl_1_3) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  sp_co_cl_1_2) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  sp_co_cl_1_1) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  con_off_4) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  con_off_3) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  con_off_2) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  con_off_1) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  L_8) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  L_7) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  L_6) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),  L_5) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),L_4 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), L_3 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), L_2 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), L_1 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), s_4_con_2 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), s_4_con_1 ) || uncond_checkmat( pad_img_2(i-1:i+1,j-1:j+1), vb_2_8) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_2_7 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), spur_2 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), spur_1 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_2_6 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1) , vb_2_5) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),vb_2_4 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_2_3 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_2_2 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_2_1 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_1_8 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_1_7 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_1_6 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_1_5 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_1_4 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_1_3 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_1_2 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_1_1 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_3_8 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_3_7 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_3_6 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_3_5 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_3_4 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_3_3 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_3_2 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_3_1 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_4_8 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_4_7 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_4_6 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_4_5 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_4_4 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_4_3 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_4_2 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), vb_4_1 )...
        || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1),db_4 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), db_3 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), db_2 ) || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), db_1)...
        || uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), sp_co_cl_1_1)|| uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), sp_co_cl_1_1)|| uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), sp_co_cl_1_2)|| uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), sp_co_cl_1_3)|| uncond_checkmat(pad_img_2(i-1:i+1,j-1:j+1), sp_co_cl_1_4);
 
        if(~ (out(i-1,j-1)&&(c||~M(i-1,j-1)))) %  c
            out(i-1,j-1) = 0;
        end
    end
end
if l==20 || l==50 || l==40
 figure;
 imshow(uint8(out*255));
 title('Output image');
end
end 



function o = uncond_checkmat(a,b)
flag = 1;

for i=1:3
    for j=1:3
        if(b(i,j)==5)
            continue;
        elseif i==2 && j==2
            continue;
        elseif (a(i,j)~=b(i,j))
            flag=0;
            break;
        end
    end
end
o = flag;
end


function c = checkmat(a,b)
i(1:3,1:3) = a==b;
j1 = [1 1 1;1 1 1;1 1 1];
if i == j1  
    c=1;
else
    c=0;
end
end
