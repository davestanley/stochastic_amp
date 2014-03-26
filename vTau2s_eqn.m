function yp = vTau2s_eqn (t, y, p)

if y(1) < 0; y(1) = 0; end

modt = mod(t,p.per);
if (modt <= p.per*p.dc)
    Ca = p.Ca_level;
else
    Ca=0;
end



yp = y;



yp(1) = (1-y(1))*p.alpha*Ca - y(1)*p.beta;

