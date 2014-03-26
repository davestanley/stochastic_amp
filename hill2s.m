
% Channel kinetics for 2-state Markov process representing SK2 transitions
% to HPo state

function [t y] = hill2s (p)
plot_on = 0;


p.per = p.per * p.factor;
p.dc = p.dc / p.factor;
p.Ca_level = p.Ca_level * p.factor;
t0 = [p.ti:1e-4:p.tf];
Ca_mean = p.Ca_level*p.dc;

% % Rates
p.n=4.1;
p.EC50 = 520e-9;
p.tau=60 / p.rate_scale; % Might want to scale this down!


% % Initial Conditions
xinf = Ca_mean^p.n / ( Ca_mean^p.n + p.EC50^p.n );      % Hill equation
% xinf = Ca_mean^p.n / ( Ca_mean + p.EC50 )^p.n;          % Independent binding
y0 = [xinf];
% if var_arr2(k) > 40
%     t0 = [0:0.01:1];
% end


options = odeset('AbsTol', 1e-9, 'RelTol', 1e-6, 'MaxStep', max(p.per*p.dc/10,2.5e-5));
% options = odeset('AbsTol', 1e-9, 'RelTol', 1e-6);
[t y] = ode45(@hill2s_eqn, t0, y0, options, p);

if plot_on; figure; plot(t,y); end

end