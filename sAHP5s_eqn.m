function yp = sAHP5s_eqn (t, y, p)

if y(1) < 0; y(1) = 0; end
if y(2) < 0; y(2) = 0; end
if y(3) < 0; y(3) = 0; end
if y(4) < 0; y(4) = 0; end

modt = mod(t,p.per);
if (modt <= p.per*p.dc)
    Ca = p.Ca_level;
else
    Ca=0;
end

a1=p.alpha1;
b1=p.beta1;
a2=p.alpha2;
b2=p.beta2;
a3=p.alpha3;
b3=p.beta3;
a4=p.alpha4;
b4=p.beta4;


yp = y;
y1 = y(1); y2 = y(2); y3 = y(3); y4 = y(4);
y5 = 1-sum(y);


yp(1) = -y1*a1*Ca + y2*b1;
yp(2) = y1*a1*Ca - y2*b1 - y2*a2*Ca + y3*b2;
yp(3) = y2*a2*Ca - y3*b2 - y3*a3*Ca + y4*b3;
yp(4) = y3*a3*Ca - y4*b3 - y4*a4*Ca + y5*b4;
% yp(5) = y4*a4*Ca - y5*b4 - y5*a5 + y6*b5;


end