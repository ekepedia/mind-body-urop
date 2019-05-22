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

%% All Memorize Trails - Left and Right

period = "Memorize";
times = enc_times;

% New Figure
f = figure;
name = sprintf("%s All %s Trials", patient, period);
figfilename = sprintf("plots/%s.jpg", name);

% Plot Trials
plotAllTrials(times, left_eda, right_eda, global_start_time, left_eda_dt);
sgtitle(name);

% Save Figure
scaleFigure(f, 1.2, 1.2);
saveFig(f, figfilename, SAVE);

%% All Memorize Trails - Left and Right (Same Y-Axis)

period = "Memorize";
times = enc_times;

% New Figure
f = figure;
name = sprintf("%s All %s Trials - Same Y-Axis", patient, period);
figfilename = sprintf("plots/%s.jpg", name);

% Plot Trials
ylimit = [13 25];
plotAllTrials(times, left_eda, right_eda, global_start_time, left_eda_dt, ylimit);
sgtitle(name);

% Save Figure
scaleFigure(f, 1.2, 1.2);
saveFig(f, figfilename, SAVE);

%% All Math Trails - Left and Right

period = "Math";
times = dis_times;

% New Figure
f = figure;
name = sprintf("%s All %s Trials", patient, period);
figfilename = sprintf("plots/%s.jpg", name);

% Plot Trials
plotAllTrials(times, left_eda, right_eda, global_start_time, left_eda_dt);
sgtitle(name);

% Save Figure
scaleFigure(f, 1.2, 1.2);
saveFig(f, figfilename, SAVE);

%% All Math Trails - Left and Right (Same Y-Axis)

period = "Math";
times = dis_times;

% New Figure
f = figure;
name = sprintf("%s All %s Trials - Same Y-Axis", patient, period);
figfilename = sprintf("plots/%s.jpg", name);

% Plot Trials
ylimit = [13 25];
plotAllTrials(times, left_eda, right_eda, global_start_time, left_eda_dt, ylimit);
sgtitle(name);

% Save Figure
scaleFigure(f, 1.2, 1.2);
saveFig(f, figfilename, SAVE);

%% All Recall Trails - Left and Right

period = "Recall";
times = rec_times;

% New Figure
f = figure;
name = sprintf("%s All %s Trials", patient, period);
figfilename = sprintf("plots/%s.jpg", name);

% Plot Trials
plotAllTrials(times, left_eda, right_eda, global_start_time, left_eda_dt);
sgtitle(name);

% Save Figure
scaleFigure(f, 1.2, 1.2);
saveFig(f, figfilename, SAVE);

%% All Recall Trails - Left and Right (Same Y-Axis)

period = "Recall";
times = rec_times;

% New Figure
f = figure;
name = sprintf("%s All %s Trials - Same Y-Axis", patient, period);
figfilename = sprintf("plots/%s.jpg", name);

% Plot Trials
ylimit = [13 25];
plotAllTrials(times, left_eda, right_eda, global_start_time, left_eda_dt, ylimit);
sgtitle(name);

% Save Figure
scaleFigure(f, 1.2, 1.2);
saveFig(f, figfilename, SAVE);
