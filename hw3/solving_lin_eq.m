% Triangle 1
x1=0; y1=0; u1 = 0; v1 =0;
x2 =-81.75 ; y2= 81.75; u2 =-81.75 ; v2= 81.75;
x3 =81.75 ; y3= 81.75; u3 =81.75 ; v3= 81.75;
x4 = -163.5; y4 =163.5; u4 = -163.5; v4 =163.5;
x5 = 163.5; y5 =163.5; u5 = 163.5; v5 =163.5;
x6 = 0; y6 = 163.5; u6 =0; v6=100.5;

% Triangle 2
x1=0; y1=0; u1 = 0; v1 =0;
x2 =-81.75 ; y2= -81.75; u2 =-81.75 ; v2= -81.75;
x3 =81.75 ; y3= -81.75; u3 =81.75 ; v3= -81.75;
x4 = -163.5; y4 =-163.5; u4 = -163.5; v4 =-163.5;
x5 = 163.5; y5 =-163.5; u5 = 163.5; v5 =-163.5;
x6 = 0; y6 = -163.5; u6 =0; v6=-100.5;

% Triangle 3
x1=0; y1=0; u1 = 0; v1 =0;
x2 =-81.75 ; y2= -81.75; u2 =-81.75 ; v2= -81.75;
x3 =-81.75 ; y3= 81.75; u3 = -81.75 ; v3= 81.75;
x4 = -163.5; y4 =-163.5; u4 = -163.5; v4 =-163.5;
x5 = -163.5; y5 =163.5; u5 = -163.5; v5 =163.5;
x6 = -163.5; y6 = 0; u6 =-100.5; v6=0;



syms a0 a1 a2 a3 a4 a5 b0 b1 b2 b3 b4 b5 
eqn1 = u1 == a0 + a1*x1 + a2*y1 + a3*x1.^2 + a4*x1*y1 + a5*y1.^2;
eqn2 = v1 == b0 + b1*x1 + b2*y1 + b3*x1.^2 + b4*x1*y1 + b5*y1.^2;
eqn3 = u2 == a0 + a1*x2 + a2*y2 + a3*x2.^2 + a4*x2*y2 + a5*y2.^2;
eqn4 = v2 == b0 + b1*x2 + b2*y2 + b3*x2.^2 + b4*x2*y2 + b5*y2.^2;
eqn5 = u3 == a0 + a1*x3 + a2*y3 + a3*x3.^2 + a4*x3*y3 + a5*y3.^2;
eqn6 = v3 == b0 + b1*x3 + b2*y3 + b3*x3.^2 + b4*x3*y3 + b5*y3.^2;
eqn7 = u4 == a0 + a1*x4 + a2*y4 + a3*x4.^2 + a4*x4*y4 + a5*y4.^2;
eqn8 = v4 == b0 + b1*x4 + b2*y4 + b3*x4.^2 + b4*x4*y4 + b5*y4.^2;
eqn9 = u5 == a0 + a1*x5 + a2*y5 + a3*x5.^2 + a4*x5*y5 + a5*y5.^2;
eqn10 = v5 == b0 + b1*x5 + b2*y5 + b3*x5.^2 + b4*x5*y5 + b5*y5.^2;
eqn11 = u6 == a0 + a1*x6 + a2*y6 + a3*x6.^2 + a4*x6*y6 + a5*y6.^2;
eqn12 = v6 == b0 + b1*x6 + b2*y6 + b3*x6.^2 + b4*x6*y6 + b5*y6.^2;

eqn = [eqn1, eqn2, eqn3, eqn4, eqn5, eqn6, eqn7, eqn8, eqn9, eqn10, eqn11, eqn12];
var = [a0, a1, a2, a3, a4, a5, b0, b1, b2, b3, b4, b5];
S = vpasolve(eqn1, eqn2, eqn3, eqn4, eqn5, eqn6, eqn7, eqn8, eqn9, eqn10, eqn11, eqn12);
a0 = double((S.a0));  b0 = double((S.b0));  
a1 = double((S.a1));  b1 = double((S.b1)); 
a2 = double((S.a2));  b2 = double((S.b2)); 
a3 = double((S.a3));  b3 = double((S.b3)); 
a4 = double((S.a4));  b4 = double((S.b4)); 
a5 = double((S.a5));  b5 = double((S.b5));