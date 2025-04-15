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