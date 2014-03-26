

function [s, p] = exp_build (p,exp_channel)


    tstart = max((p.tf - p.ti) / 10, p.per);
    tstart = p.tf-1;
    tstart = 0.0;
    tstart = tstart*p.period_scale;
    s.varname = ['pulse ' num2str(p.factor)];
    
    if (isempty(exp_channel)); exp_channel = ''; end;
    

    j=1;
    if strcmp('hill2s',exp_channel)
        fprintf ([' Running ' exp_channel '\n']);
        s.column_names{j}='hill2s';
        [t y] = hill2s(p);
        [tstartind] = find(t >= tstart,1,'first');
        s.column{j}.datatimes=t(tstartind:end);
        s.column{j}.data=y(tstartind:end);
%         s.column{j}=statsshort_struct(s.column{j});
    end
    
    j=j+1;
    if strcmp('vTau2s',exp_channel)
        fprintf ([' Running ' exp_channel '\n']);
        s.column_names{j}='vTau2s';
        % % Rates
        p.rb = 10e6*300/750*p.rate_scale;
        p.ru = 0.5*p.rate_scale;
        p.alpha = 1*p.rb;
        p.beta = 1*p.ru;
        [t y theory] = vTau2s(p);
            [tstartind] = find(t >= tstart,1,'first');
        s.column{j}.datatimes=t(tstartind:end);
        s.column{j}.data=y(tstartind:end);
%         s.column{j}=statsshort_struct(s.column{j});
        s.column{j}.theory = theory;
    end
    
    j=j+1;
    if strcmp('vTau3s',exp_channel)
        fprintf ([' Running ' exp_channel '\n']);
        s.column_names{j}='vTau3s';
        % % Rates
        p.rb = 10e6*30/750*p.rate_scale;
        p.ru = 0.5*p.rate_scale;
        p.alpha1 = 2*p.rb;
        p.beta1 = 1*p.ru;
        p.alpha2 = 1*p.rb;
        p.beta2 = 2*p.ru;
        [t y theory] = vTau3s(p);
            [tstartind] = find(t >= tstart,1,'first');
        s.column{j}.datatimes=t(tstartind:end);
        s.column{j}.data=y(tstartind:end);
%         s.column{j}=statsshort_struct(s.column{j});
        s.column{j}.theory = theory;
    end
    
    j=j+1;
    if strcmp('sAHP5s',exp_channel)
        fprintf ([' Running ' exp_channel '\n']);
        s.column_names{j}='sAHP5s';
        [t y] = sAHP5s(p);
            [tstartind] = find(t >= tstart,1,'first');
        s.column{j}.datatimes=t(tstartind:end);
        s.column{j}.data=y(tstartind:end);
%         s.column{j}=statsshort_struct(s.column{j});
    end
    
    j=j+1;
    if strcmp('sAHP6s',exp_channel)
        fprintf ([' Running ' exp_channel '\n']);
        s.column_names{j}='sAHP6s';
        [t y] = sAHP6s(p);
            [tstartind] = find(t >= tstart,1,'first');
        s.column{j}.datatimes=t(tstartind:end);
        s.column{j}.data=y(tstartind:end);
%         s.column{j}=statsshort_struct(s.column{j});
    end
    
    j=1+1;
    if strcmp('hill2s_imsAHP5s',exp_channel)
        fprintf ([' Running ' exp_channel '\n']);
        s.column_names{j}='hill2s_imsAHP5s';
        [t y] = hill2s_imsAHP5s(p);
        [tstartind] = find(t >= tstart,1,'first');
        s.column{j}.datatimes=t(tstartind:end);
        s.column{j}.data=y(tstartind:end);
%         s.column{j}=statsshort_struct(s.column{j});
    end
    
    j=1+1;
    if strcmp('SK2_6s',exp_channel)
        fprintf ([' Running ' exp_channel '\n']);
        s.column_names{j}='SK2_6s';
        p.SK2h=0;
        [t y] = SK2_6s(p);
        [tstartind] = find(t >= tstart,1,'first');
        s.column{j}.datatimes=t(tstartind:end);
        s.column{j}.data=y(tstartind:end);
%         s.column{j}=statsshort_struct(s.column{j});
    end
    
    j=1+1;
    if strcmp('SK2h_6s',exp_channel)
        fprintf ([' Running ' exp_channel '\n']);
        s.column_names{j}='SK2h_6s';
        p.SK2h=1;
        [t y] = SK2_6s(p);
        [tstartind] = find(t >= tstart,1,'first');
        s.column{j}.datatimes=t(tstartind:end);
        s.column{j}.data=y(tstartind:end);
%         s.column{j}=statsshort_struct(s.column{j});
    end

end



function s = statsshort_struct(s)
    s.statsdata.mean = mean(s.data);
    s.statsdata.meanerr = 0;
    s.statsdata.std = std(s.data);
    s.statsdata.stderr = 0;
end


