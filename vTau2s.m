
% Simple channel with 2-state kinetic scheme (eqn 16-17 in Stanley et al, 2011)

function [t y theory] = vTau2s (p)

plot_on = 0;
only_theory = 1;

T0 = p.per;         % Get default values prior to scaling
A0 = p.Ca_level;
Ca_level = p.Ca_level * p.factor;

p.per = p.per * p.factor;
p.dc = p.dc / p.factor;
p.Ca_level = p.Ca_level * p.factor;
dt = 1e-4;
t0 = [p.ti:dt:p.tf];
Ca_mean = p.Ca_level*p.dc;



% %  Initial Conditions
xinf = Ca_mean * p.alpha / (Ca_mean * p.alpha + p.beta);
y0 = [xinf];

if ~only_theory
    options = odeset('AbsTol', 1e-9, 'RelTol', 1e-6, 'MaxStep', max(p.per*p.dc/10,2.5e-5));
    [t y] = ode45(@vTau2s_eqn, t0, y0, options, p);
end



nalpha = p.rb;
nbeta = p.ru;

T1 = p.per * p.dc;
T2 = p.per * (1-p.dc);

% X is phase of square wave when Ca?0; Y is phase when Ca=0
taux = 1/(nalpha*Ca_level+nbeta);
tauy = 1/(nbeta);
xinf = nalpha*Ca_level / (nalpha*Ca_level + nbeta);
yinf = 0;

y0 = xinf * (1-exp(-T1/taux)) / (1-exp(-T2/tauy)*exp(-T1/taux));
x0 = y0 * exp(-T2/tauy);

Xindex = find( (0 <= (mod(t0, p.per))) .* ((mod(t0, p.per)) < p.per*p.dc));
Yindex = find( (p.per*p.dc <= (mod(t0, p.per))) .* ((mod(t0, p.per)) < p.per));

theory.t = t0;
theory.y = zeros(1,length(t0));
theory.y(Xindex) = xinf + (x0 - xinf)*exp(-mod(t0(Xindex),p.per)/taux);
theory.y(Yindex) = yinf + (y0 - yinf)*exp(-(mod(t0(Yindex),p.per)-p.per*p.dc)/tauy);


% xbar = xinf + taux/T1*(x0-xinf)*(1-exp(-T1/taux));
% ybar = y0*tauy/T2*(1-exp(-T2/tauy));
% 
% meanval = (xbar*T1 + ybar*T2) / (T1 + T2);
% figure;
% plot(Xindex); hold on; plot(Yindex,'r');

if plot_on;
    figure; plot(t,y); 
    hold on; plot(t,theory.y,'r');
end

if only_theory
    y = theory.y;
    t = theory.t;
end

end


