function yp = hill2s_eqn (t, y, p)


if y(1) < 0; y(1) = 0; end

modt = mod(t,p.per);
if (modt <= p.per*p.dc)
    Ca = p.Ca_level;
else
    Ca=0;
end

n=p.n;
EC50 = p.EC50;




xinf = Ca^n / ( Ca^n + EC50^n );
% xinf = Ca^n / ( Ca + EC50 )^n;
tau = p.tau;
tau = p.tau*EC50/(Ca+EC50/2);

alpha = xinf/tau;
beta= (1-xinf)/tau;

yp = y;
yp(1) = (1-y(1))*alpha - y(1)*beta;


end