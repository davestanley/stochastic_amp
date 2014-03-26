
% Like sAHP6s, except disregard high-rate transitions between C and O
% for increased processing time


function [t y] = sAHP5s (p)

plot_on = 0;

% % % Period, duty cycle of Ca, and total sim time
% p.factor = 2;
% p.rate_scale = 10.0;
% p.ti = 0;
% p.tf = 1;
% 
% p.per = 0.02;
% p.dc = 1.0;
% p.Ca_level = 50e-9;


p.per = p.per * p.factor;
p.dc = p.dc / p.factor;
p.Ca_level = p.Ca_level * p.factor;
t0 = [p.ti:1e-4:p.tf];
Ca_mean = p.Ca_level*p.dc;

% % Rates
rb = 10e6*300/750*p.rate_scale;
ru = 0.5*p.rate_scale;
p.alpha1 = 4*rb;
p.beta1 = 1*ru;
p.alpha2 = 3*rb;
p.beta2 = 2*ru;
p.alpha3 = 2*rb;
p.beta3 = 3*ru;
p.alpha4 = 1*rb;
p.beta4 = 4*ru;

% %  Initial Conditions
xsing_inf = Ca_mean*rb / (Ca_mean*rb + ru);
x1inf = 1*(1-xsing_inf)^4*(xsing_inf)^0;
x2inf = 4*(1-xsing_inf)^3*(xsing_inf)^1;
x3inf = 6*(1-xsing_inf)^2*(xsing_inf)^2;
x4inf = 4*(1-xsing_inf)^1*(xsing_inf)^3;
% x5inf = 1*(1-xsing_inf)^0*(xsing_inf)^4;
y0 = [x1inf x2inf x3inf x4inf];


options = odeset('AbsTol', 1e-9, 'RelTol', 1e-6, 'MaxStep', max(p.per*p.dc/10,2.5e-5));
[t yarr] = ode45(@sAHP5s_eqn, t0, y0, options, p);
y = 1-sum(yarr,2);

if plot_on; figure; plot(t,[yarr y]); legend('1','2','3','4','5'); end
if plot_on; figure; plot(t,y); end


end

