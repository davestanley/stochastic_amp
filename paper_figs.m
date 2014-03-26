


resimulate=0;
set_values=0;

plot_on = 0;    % Turns plotting on or off - useful to turn it off when using a script
plot_raw = 1;
plot_PSD = 0;
plot_stdev = 1;

exps_to_plot=[0];

plot_voltage = 0;
plot_across_experiments = 1;
    exp_channel='sAHP5s';

plot_across_channels = ~(plot_across_experiments || plot_voltage); % Do either one or the other!
    plotchans = {'hill2s','vTau2s','sAHP5s','sAHP6s','hill2s_imsAHP5s','SK2_6s','SK2h_6s'}; 
    if (plot_across_channels); exp_channel = []; end

koch_format = 0;% Get in Koch format;
normalize_raw=0;
sub_min_raw=1;
statsdata_val='statsdata.mean';
statsdata_err='statsdata.meanerr';


plotrange = 1:4;
jjj=0;
while max(plotrange < length(tempdat2) )
    jjj=jjj+1;
    plot_struct
    plotrange = plotrange + 8;
    if plot_stdev
        x{jjj}=plotmat';
        x_err{jjj}=plotmat_err';
    end
end

if plot_stdev
    combplot = cell2mat(x);
    combplot_err = cell2mat(x_err);
    figure; plot_bar(combplot, combplot_err, leg_arr);
end

clear resimulate

