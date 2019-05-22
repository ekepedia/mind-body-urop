function [enc_times, dis_times, rec_times] = extractTrials(filename)

% Load Preprocessed Masterlog
% TODO: Programmatically parse masterlog.txt
g = load(filename) ;
fieldname = fieldnames(g);
triallog = getfield(g, fieldname{1});

% start and end time for 3 conditions (2 x 3 = 6)
size = 6;
trials = max(table2array(triallog(:,3)));

enc_times = [];
dis_times = [];
rec_times = [];

for trial = 1:trials
    
    index = (trial - 1)*size;
    
    enc_start = datestr(table2array(triallog(index + 1,1)), 'HH:MM:SS');
    enc_end   = datestr(table2array(triallog(index + 2,1)), 'HH:MM:SS');
    dis_start = datestr(table2array(triallog(index + 3,1)), 'HH:MM:SS');
    dis_end   = datestr(table2array(triallog(index + 4,1)), 'HH:MM:SS');
    rec_start = datestr(table2array(triallog(index + 5,1)), 'HH:MM:SS');
    rec_end   = datestr(table2array(triallog(index + 6,1)), 'HH:MM:SS');
    
    enc_times = [enc_times; [{enc_start} {enc_end}]];
    dis_times = [dis_times; [{dis_start} {dis_end}]];
    rec_times = [rec_times; [{rec_start} {rec_end}]];
end
end

