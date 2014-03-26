
% Channel kinetics for SK2 channel. Used for both LPo and HPo behavour. 
% Set p.SK2h to 1 for HPo behaviour.

function [t y] = SK2_6s (p)

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

p.alpha1 = 30e6 * p.rate_scale;
p.alpha2 = 24e6 * p.rate_scale;
p.beta2 = 80 * p.rate_scale;
p.alpha3 = 12e6 * p.rate_scale;
p.delta3 = 160 * p.rate_scale;
p.beta3 = 80 * p.rate_scale;
p.delta4 = 1200 * p.rate_scale;
p.beta4 = 200 * p.rate_scale;
p.gamma5 = 1000 * p.rate_scale;
p.gamma6 = 100 * p.rate_scale;

if p.SK2h == 1
    p.alpha1 = 200e6 * p.rate_scale;
    p.alpha2 = 160e6 * p.rate_scale;
    p.alpha3 = 80e6 * p.rate_scale;
end


% %  Initial Conditions
x1inf = 1;
x2inf = 0;
x3inf = 0;
x4inf = 0;
x5inf = 0;
y0 = [x1inf x2inf x3inf x4inf x5inf];


options = odeset('AbsTol', 1e-9, 'RelTol', 1e-6, 'MaxStep', max(p.per*p.dc/10,2.5e-5));
[t yarr] = ode45(@SK2_6s_eqn, t0, y0, options, p);
y6 = 1-sum(yarr,2);
y = yarr(:,5) + y6;

if plot_on; figure; plot(t,[yarr y]); legend('1','2','3','4','5','6'); end
if plot_on; figure; plot(t,y); end


end

