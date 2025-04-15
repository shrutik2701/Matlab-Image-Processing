function b = Floyd_Steinberg(img,x,y)

% Error diffusion
% FLOYD STEINBERG
h1 = 1/16.*[0 0 0 ; 0 0 7;3 5 1];
f = zeropad(img.*255,3);
b = zeros (x,y);
T =128;
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

end


