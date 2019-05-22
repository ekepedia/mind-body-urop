%% Load Data

% Set Default Figure Properties
set(0, 'DefaultLineLineWidth', 1);
addpath("./plots");

% Set Save Figure Parameter
% 0 = don't save, 1 = save
SAVE = 0;

patient = "P01";

% EDA File Names
left_eda_filename = sprintf("%s/E4_L/EDA.csv", patient);
right_eda_filename = sprintf("%s/E4_R/EDA.csv", patient);
left_eda_start_filename = sprintf("%s/E4_L/t_start.txt", patient);
right_eda_start_filename = sprintf("%s/E4_R/t_start.txt", patient);

% Load EDA Data
[ global_start_time, left_eda, right_eda, left_eda_dt, right_eda_dt ] = extract_eda_data(...
    left_eda_filename,right_eda_filename, ...
    left_eda_start_filename,right_eda_start_filename);

% Extract Trial Time Stamps
[enc_times, dis_times, rec_times] = extractTrials('P01Trials.mat');


%% Plot Trials

% Number of trials
trials = length(enc_times);

% How many trials to plot at once
groups = 5;

% Number of observations
N = length(left_eda);

% Create time vector
Tvec = datetime(indextotime(1:N, global_start_time, left_eda_dt));

for i = 1:groups:trials
% New Figure
f = figure;
t_start = i;
t_end = i + 4;
name = sprintf("%s EDA Trials %d-%d", patient, t_start, t_end);
figfilename = sprintf("plots/%s.jpg", name);

if t_start <= 1
    % Beginning of First Trial
    t1 = char(enc_times(1,1));
else
    % End of the previous Trial
    t1 = char(rec_times(t_start - 1,2));
end

if t_end >= trials
    % End of Last Trial
    t2 = char(rec_times(trials,2));
else
    % Beginning of the next trial
    t2 = char(enc_times(t_end + 1,1));
end

hold on
plot(Tvec, left_eda, "b");
plot(Tvec, right_eda, "r");
highlightTimeRanges(enc_times, "g");
highlightTimeRanges(dis_times, "k");
highlightTimeRanges(rec_times, "r");
hold off

default_format(gca, name,"Time","Conductance \muS")
xlim(datetime([t1; t2]))
ylim([13 27])
xtickformat('hh:mm:ss');

saveFig(f, figfilename, SAVE)
end