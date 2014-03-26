



clc

resimulate = 1;
if resimulate;
    clear; resimulate = 1;
end

varyAHP1=0;
varyAHP2=0;

% varyAHP1=1;
varyAHP2=1;



% % % Period, duty cycle of Ca, and total sim time

p.period_scale = 1.0;
p.rate_scale = 10.0;
p.ti = 0;
p.tf = 100;

p.per = 0.02;
p.dc = 1.0;
p.Ca_level = 75e-9;
p.per = p.per*p.period_scale;
p.tf = p.tf * p.period_scale;


plotrange = [1 2 4 8 16 32 64 128];
plotchans = {'hill2s','vTau2s','sAHP5s','sAHP6s','hill2s_imsAHP5s','SK2_6s','SK2h_6s'}; 
exp_channel='sAHP5s';
array_index = 0;

if varyAHP1
    p.rate_scale = 1.0;
    for i = 1:length(plotrange)
        p.factor = plotrange(i);
        array_index = array_index + 1;
        if resimulate; tempdat2{array_index} = exp_build(p,exp_channel); end
    %     tempdat2{i} = exp_stats(p,tempdat2{i});
    end

    % p.rate_scale = 2.0;
    % for i = 1:length(plotrange)
    %     p.factor = plotrange(i);
    %     array_index = array_index + 1;
    %     if resimulate; tempdat2{array_index} = exp_build(p,exp_channel); end
    % %     tempdat2{i} = exp_stats(p,tempdat2{i});
    % end

    p.rate_scale = 4.0;
    for i = 1:length(plotrange)
        p.factor = plotrange(i);
        array_index = array_index + 1;
        if resimulate; tempdat2{array_index} = exp_build(p,exp_channel); end
    %     tempdat2{i} = exp_stats(p,tempdat2{i});
    end

    % p.rate_scale = 8.0;
    % for i = 1:length(plotrange)
    %     p.factor = plotrange(i);
    %     array_index = array_index + 1;
    %     if resimulate; tempdat2{array_index} = exp_build(p,exp_channel); end
    % %     tempdat2{i} = exp_stats(p,tempdat2{i});
    % end

    p.rate_scale = 16.0;
    for i = 1:length(plotrange)
        p.factor = plotrange(i);
        array_index = array_index + 1;
        if resimulate; tempdat2{array_index} = exp_build(p,exp_channel); end
    %     tempdat2{i} = exp_stats(p,tempdat2{i});
    end

    % p.rate_scale = 32.0;
    % for i = 1:length(plotrange)
    %     p.factor = plotrange(i);
    %     array_index = array_index + 1;
    %     if resimulate; tempdat2{array_index} = exp_build(p,exp_channel); end
    % %     tempdat2{i} = exp_stats(p,tempdat2{i});
    % end

    p.rate_scale = 64.0;
    for i = 1:length(plotrange)
        p.factor = plotrange(i);
        array_index = array_index + 1;
        if resimulate; tempdat2{array_index} = exp_build(p,exp_channel); end
    %     tempdat2{i} = exp_stats(p,tempdat2{i});
    end

    p.rate_scale = 128.0;
    for i = 1:length(plotrange)
        p.factor = plotrange(i);
        array_index = array_index + 1;
        if resimulate; tempdat2{array_index} = exp_build(p,exp_channel); end
    %     tempdat2{i} = exp_stats(p,tempdat2{i});
    end

end



if varyAHP2
    p.rate_scale = 0.1;
    for i = 1:length(plotrange)
        p.factor = plotrange(i);
        array_index = array_index + 1;
        if resimulate; tempdat2{array_index} = exp_build(p,exp_channel); end
    %     tempdat2{i} = exp_stats(p,tempdat2{i});
    end

    p.rate_scale = 0.2;
    for i = 1:length(plotrange)
        p.factor = plotrange(i);
        array_index = array_index + 1;
        if resimulate; tempdat2{array_index} = exp_build(p,exp_channel); end
    %     tempdat2{i} = exp_stats(p,tempdat2{i});
    end
    
    p.rate_scale = 0.4;
    for i = 1:length(plotrange)
        p.factor = plotrange(i);
        array_index = array_index + 1;
        if resimulate; tempdat2{array_index} = exp_build(p,exp_channel); end
    %     tempdat2{i} = exp_stats(p,tempdat2{i});
    end
    
    p.rate_scale = 0.8;
    for i = 1:length(plotrange)
        p.factor = plotrange(i);
        array_index = array_index + 1;
        if resimulate; tempdat2{array_index} = exp_build(p,exp_channel); end
    %     tempdat2{i} = exp_stats(p,tempdat2{i});
    end


end




