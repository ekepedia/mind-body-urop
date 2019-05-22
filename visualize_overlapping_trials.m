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

%% Memorize Trails - Left EDA

period = "Memorize";
times = enc_times;
eda = left_eda;
dt = left_eda_dt;
side = "Left";

% New Figure
f = figure;
name = sprintf("%s All %s Trials - %s EDA", patient, period, side);
figfilename = sprintf("plots/%s.jpg", name);

% Plot Trials
plotOverlappingTrials(times, eda, global_start_time, dt)
sgtitle(name);

% Save Figure
scaleFigure(f, 2.5, 1);
saveFig(f, figfilename, SAVE);

%% Memorize Trails - Right EDA

period = "Memorize";
times = enc_times;
eda = right_eda;
dt = right_eda_dt;
side = "Right";

% New Figure
f = figure;
name = sprintf("%s All %s Trials - %s EDA", patient, period, side);
figfilename = sprintf("plots/%s.jpg", name);

% Plot Trials
plotOverlappingTrials(times, eda, global_start_time, dt)
sgtitle(name);

% Save Figure
scaleFigure(f, 1.2, 1.2);
saveFig(f, figfilename, SAVE);

%% Math Trails - Left EDA

period = "Math";
times = dis_times;
eda = left_eda;
dt = left_eda_dt;
side = "Left";

% New Figure
f = figure;
name = sprintf("%s All %s Trials - %s EDA", patient, period, side);
figfilename = sprintf("plots/%s.jpg", name);

% Plot Trials
plotOverlappingTrials(times, eda, global_start_time, dt)
sgtitle(name);

% Save Figure
scaleFigure(f, 2.5, 1);
saveFig(f, figfilename, SAVE);

%% Math Trails - Right EDA

period = "Math";
times = dis_times;
eda = right_eda;
dt = right_eda_dt;
side = "Right";

% New Figure
f = figure;
name = sprintf("%s All %s Trials - %s EDA", patient, period, side);
figfilename = sprintf("plots/%s.jpg", name);

% Plot Trials
plotOverlappingTrials(times, eda, global_start_time, dt)
sgtitle(name);

% Save Figure
scaleFigure(f, 1.2, 1.2);
saveFig(f, figfilename, SAVE);

%% Recall Trails - Left EDA

period = "Recall";
times = rec_times;
eda = left_eda;
dt = left_eda_dt;
side = "Left";

% New Figure
f = figure;
name = sprintf("%s All %s Trials - %s EDA", patient, period, side);
figfilename = sprintf("plots/%s.jpg", name);

% Plot Trials
plotOverlappingTrials(times, eda, global_start_time, dt)
sgtitle(name);

% Save Figure
scaleFigure(f, 2.5, 1);
saveFig(f, figfilename, SAVE);

%% Recall Trails - Right EDA

period = "Recall";
times = rec_times;
eda = right_eda;
dt = right_eda_dt;
side = "Right";

% New Figure
f = figure;
name = sprintf("%s All %s Trials - %s EDA", patient, period, side);
figfilename = sprintf("plots/%s.jpg", name);

% Plot Trials
plotOverlappingTrials(times, eda, global_start_time, dt)
sgtitle(name);

% Save Figure
scaleFigure(f, 1.2, 1.2);
saveFig(f, figfilename, SAVE);
