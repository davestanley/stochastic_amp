function yp = SK2_6s_eqn(t, y, p)

if y(1) < 0; y(1) = 0; end
if y(2) < 0; y(2) = 0; end
if y(3) < 0; y(3) = 0; end
if y(4) < 0; y(4) = 0; end
if y(5) < 0; y(5) = 0; end

modt = mod(t,p.per);
if (modt <= p.per*p.dc)
    Ca = p.Ca_level;
else
    Ca=0;
end

a1=p.alpha1;
a2=p.alpha2;
b2=p.beta2;
a3=p.alpha3;
d3=p.delta3;
b3=p.beta3;
d4=p.delta4;
b4=p.beta4;
g5=p.gamma5;
g6=p.gamma6;




yp = y;
y1 = y(1); y2 = y(2); y3 = y(3); y4 = y(4); y5 = y(5);
y6 = 1-sum(y);
% y6 = y(6);


yp(1) = -y1*a1*Ca + y2*b2;
yp(2) = y1*a1*Ca - y2*b2 - y2*a2*Ca + y3*b3;
yp(3) = y2*a2*Ca - y3*b3 - y3*a3*Ca + y4*b4 - y3*d3 + y5*g5;
yp(4) = y3*a3*Ca - y4*b4 - y4*d4 + y6*g6;
yp(5) = y3*d3 - y5*g5;

% Redo typing...
% yp(1) = -y1*a1*Ca + y2*b2;
% yp(2) = y1*a1*Ca - y2*b2 - y2*a2*Ca + y3*b3;
% yp(3) = y2*a2*Ca - y3*b3 - y3*a3*Ca + y4*b4 - y3*d3 + y5*g5;
% yp(4) = y3*a3*Ca - y4*b4 - y4*d4 + y6*g6;
% yp(5) = y3*d3 - y5*g5;


end