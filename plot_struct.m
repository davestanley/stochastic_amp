

% Matlab 2008b
% David Arthur Stanley
% david.A.stanley@asu.edu
% Arizona State University, Feb 28, 2011


% Units:
	% Time is measured in seconds
	% Calcium concentration is measured in Mols
	% Channel activation is given in probabilities, with 1.0 being open.


clc; clear all;
resimulate = 1;
set_values=1;


if set_values && resimulate
    plot_on = 1;    % Turns plotting on or off - useful to turn it off when using a script
    plot_raw = 1;   % Plot raw time series data
    plot_PSD = 0;   % Plot power spectral density (not yet implemented)
    plot_meanbar = 1; % Plot a bar graph of standard deviations
    
    exps_to_plot=[0];   % Leave this as default. This is used when embedding plot_struct within a larger script file
                        % to enable multiple subsets of scalingfactors to be run
    

    plot_across_experiments = 1;    % Plot one channel type under many different pulse protocols
        scalingfactors = [1 2 4 8 16 32 64 128]; % Scaling factor for calcium pulse height (p.Ca_level, defined below) is scaled by each of these values.
        								% Briefly, the calcium signal associated with scalingfactors=[1] is fixed at p.Ca_level (default 75nM).
       									% The calcium signal for scalingfactors=[2] is a 14msec pulse of height 150nM, followed by
       									% 14msec when calcium is zero. This preserves the mean Ca level at 75nM. Similarly for scalingfactors > 2.
        channel_list= {'hill2s','vTau2s','sAHP5s','sAHP6s','SK2_6s','SK2h_6s'}; % List of possible channels we have implemented
        exp_channel=channel_list{5};   % Channel name to plot; #5 is SK2 (in sLPo state)
        plot_theory = 0; % Plot analytical curves, rather than those calculated numerically (not implemented for all channels)
        


    statsdata_val='statsdata.mean';
    statsdata_err='statsdata.meanerr';
end


% % % Period, duty cycle of Ca, and total sim time

p.period_scale = 1.0;   % Scale the period of the pulse protocol (time-scales the input signal by this value)
p.rate_scale = 1;       % Scale the rate constants of the channel by this value
p.ti = 0;               % Simulation start time (seconds)
p.tf = 10;               % Simulation stop time (default=180 sec, very slow)

p.per = 0.014;           % Period of the default pulse protocol (seconds)
p.dc = 1.0;             % Duty cycle of the defualt pulse
p.Ca_level = 75e-9;     % Pulse height (default)
p.per = p.per*p.period_scale;   % Implement period scale
p.tf = p.tf * p.period_scale;   % Implement period scale
p.stats_start = 3.1;            % Settling time to wait before calculating stats. Should be adjusted depending on settling time of channel


for i = scalingfactors
    p.factor = i;       % Sets the factor by which to scale pulse height and total pulse length
    if resimulate; [tempdat2{i}, p] = exp_build(p,exp_channel); end
    tempdat2{i} = exp_stats(p,tempdat2{i});
end

% Plot single channel, multiple experiments
for jj = exps_to_plot
    if plot_across_experiments
        scalingfactors = [(scalingfactors+jj)];
        col_num = find_columns( tempdat2{scalingfactors(1)}.column_names,{exp_channel}); col_numstr=num2str(col_num);
        titlestr = strrep (tempdat2{scalingfactors(1)}.column_names{col_num},'_',' ');
        if plot_raw
            [plotmat leg_arr]= struct2matrix({tempdat2{scalingfactors}},['column{' col_numstr '}.data'], 'varname');
            if plot_theory; [plotmat_theory leg_arr]= struct2matrix({tempdat2{scalingfactors}},['column{' col_numstr '}.theory.y'], 'varname'); end
            t = tempdat2{scalingfactors(1)}.column{col_num}.datatimes;
            if plot_theory; t_theory = tempdat2{scalingfactors(1)}.column{col_num}.theory.t; end
            clear pso; pso.shift = -0.0e-11; pso.ds=1; pso.zero_means=0;
            if plot_on;
                figure;
                plot_matrix (t, plotmat, pso, leg_arr);
                if plot_theory; hold on; plot_matrix(t_theory, plotmat_theory, pso); end
                title (['Plotting ' titlestr]);
                xlabel('time(s)'); 
                ylabel('Open probability');
            end
            
        end
        if plot_PSD
            [plotmat leg_arr]= struct2matrix({tempdat2{scalingfactors}},['column{' col_numstr '}.fft.psd'], 'varname');
    %         plotmat=abs(plotmat).^2;
            f = tempdat2{scalingfactors(1)}.column{col_num}.fft.f;
            clear pso; pso.plotloglog=1;
            if plot_on; figure; plot_matrix (f, plotmat, pso, leg_arr); title (['Plotting ' titlestr]); end
        end
        if plot_meanbar
            [plotmat leg_arr] = struct2matrix({tempdat2{scalingfactors}},['column{' col_numstr '}.' statsdata_val],'varname');
            [plotmat_err leg_arr] = struct2matrix({tempdat2{scalingfactors}},['column{' col_numstr '}.' statsdata_err],'varname');
            
            if strcmp(tempdat2{scalingfactors(1)}.column_names{col_num},'vTau2s')
                [plotmat2 leg_arr] = struct2matrix({tempdat2{scalingfactors}},['column{' col_numstr '}.statsdata.theoreticalmean'],'varname');
            end
            
            if plot_on; figure; plot_bar([plotmat'], plotmat_err', leg_arr); title (['Plotting ' titlestr]); xlabel('Pulse scaling factor'); ylabel('Mean open probability'); end
        end
    end
end




