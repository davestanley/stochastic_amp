

function s = exp_stats (p,s)

%     tstart = max((p.tf - p.ti) / 10, p.per);
%     tstart = p.tf-1;
%     tstart = 2.5;
%     tstart = 0;
    tstart = p.stats_start;
    tstart = tstart*p.period_scale;
    s.varname = ['pulse ' num2str(p.factor)];
    
    
    for j = 1:length(s.column_names)
        if ~isempty(s.column_names{j});
            t = s.column{j}.datatimes;
            [tstartind] = find(t >= tstart,1,'first');
            s.column{j}.datatimes = s.column{j}.datatimes(tstartind:end);
            s.column{j}.data = s.column{j}.data(tstartind:end);
            s.column{j}=statsshort_struct(s.column{j});
            
            % Get theoretical mean values
            if strcmp(s.column_names{j},'vTau2s')
                s.column{j}.statsdata.theoreticalmean = get_mean_n(p);
            end
        end
    end

end



function s = statsshort_struct(s)
    s.statsdata.mean = mean(s.data);
    s.statsdata.meanerr = 0;    % Not used
    s.statsdata.std = std(s.data);
    s.statsdata.stderr = 0;
end


function meanval = get_mean_n(p, s) % For testing...

    use_Taylor_series_approx=0;

    T0 = p.per;         % Get default values prior to scaling
    A0 = p.Ca_level;

    p.per = p.per * p.factor;
    p.dc = p.dc / p.factor;
    Ca_level = p.Ca_level * p.factor;
    
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
    
    % Taylor series approximation
    if use_Taylor_series_approx
        y0 = xinf * (T1/taux) / (T1/taux + T2/tauy - T1/taux*T2/tauy);
        y0 = xinf * (T1/taux) / (T1/taux + T2/tauy);
        x0 = y0 * (1-T2/tauy);
    end
    
    
    xbar = xinf + taux/T1*(x0-xinf)*(1-exp(-T1/taux));
    ybar = y0*tauy/T2*(1-exp(-T2/tauy));
    
    meanval = (xbar*T1 + ybar*T2) / (T1 + T2);
    
    % Taylor series approximation
    if use_Taylor_series_approx
        meanval = nalpha * A0 * T1 / (nalpha*A0*T1 + T0*nbeta);
    end
    
    % If input signal is constant....
    if p.dc == 1
        meanval = xinf;
    end
        
end





