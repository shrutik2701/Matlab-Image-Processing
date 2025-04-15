% Name: Shruti Kulkarni
% USCID: 3875936136
% Email: shrutik@usc.edu
% Submission Date: 28 Jan, 2024

function val = conv_img(mat1, mat2 )
val=0;
for i=1:size(mat1,1)
    for j = 1:size(mat1,2)
        val = val + mat1(i,j)*mat2(i,j);
    end
end
end
