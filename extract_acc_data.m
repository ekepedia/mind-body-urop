function [ global_start_time, left_eda, right_eda, left_eda_dt, right_eda_dt ] = extract_data () 

%% Open files
% The follwing lines of code specify the files used in this script. Note folder strucutre

left_eda_file = fopen("E4_L/EDA.csv");
right_eda_file = fopen("E4_R/EDA.csv");
left_acc_file = fopen("E4_L/ACC.csv");
right_acc_file = fopen("E4_R/ACC.csv");
left_eda_start_file = fopen("E4_L/t_start.txt");
right_eda_start_file = fopen("E4_R/t_start.txt");

%% Read EDA
% The follwing lines of code read the EDA data
% Read EDA Data From CSV
left_eda_raw = textscan(left_eda_file, '%f', 'Delimiter',',', 'HeaderLines',1);
right_eda_raw = textscan(right_eda_file, '%f', 'Delimiter',',', 'HeaderLines',1);

% Close EDA Files
fclose(left_eda_file);
fclose(right_eda_file);

% Extract EDA Data
left_eda_extracted = left_eda_raw(1);
right_eda_extracted = right_eda_raw(1);

% Pull EDA Values
left_eda = left_eda_extracted{1};
right_eda = right_eda_extracted{1};

%% Read Time
% The following lines of code extract time related data: frequencies, time steps, start times, and time indexes.

% Extract Frequencies from CSV
left_eda_fq = left_eda(1);              % Hz
left_eda_dt = 1 / left_eda_fq * 1000;   % msec
left_eda = left_eda(2:end); 
right_eda_fq = right_eda(1);
right_eda_dt = 1 / right_eda_fq * 1000; % Hz
right_eda = right_eda(2:end);           % msec

% Read Start Times From TXT
left_eda_start_raw = textscan(left_eda_start_file, '%s%f%f%f%f');
right_eda_start_raw = textscan(right_eda_start_file, '%s%f%f%f%f');

% Close Time Files
fclose(left_eda_start_file);
fclose(right_eda_start_file);

% Extract Start Times and Convert from Days to Milliseconds
conversion = 24 * 60 *60 * 1000;
left_start_millisecond = datenum(char(left_eda_start_raw{1}),'HH:MM:SS.FFF') * conversion;
right_start_millisecond = datenum(char(right_eda_start_raw{1}),'HH:MM:SS.FFF') * conversion;

% Determine Indexes
left_time_index = (1:length(left_eda)) * left_eda_dt + left_start_millisecond;
right_time_index = (1:length(right_eda)) * right_eda_dt + right_start_millisecond;

%% Read ACC
%The following lines of code extra the ACC Data, frequencies, and time data

% Read ACC Data From CSV
left_acc_raw = textscan(left_acc_file, '%f %f %f', 'Delimiter',',', 'HeaderLines',1);
right_acc_raw = textscan(right_acc_file, '%f %f %f', 'Delimiter',',', 'HeaderLines',1);

% Close ACC Files
fclose(left_acc_file);
fclose(right_acc_file);

% Extract ACC Data
left_acc_extracted_x = left_acc_raw(1);
left_acc_extracted_y = left_acc_raw(2);
left_acc_extracted_z = left_acc_raw(3);
right_acc_extracted_x = right_acc_raw(1);
right_acc_extracted_y = right_acc_raw(2);
right_acc_extracted_z = right_acc_raw(3);

% Pull ACC Values
left_acc_x = left_acc_extracted_x{1};
left_acc_y = left_acc_extracted_y{1};
left_acc_z = left_acc_extracted_z{1};
right_acc_x = right_acc_extracted_x{1};
right_acc_y = right_acc_extracted_y{1};
right_acc_z = right_acc_extracted_z{1};

% Extract ACC Frequencies (assuming x = y = z Hz)
left_acc_fq = left_acc_x(1);              % Hz
left_acc_dt = 1 / left_acc_fq * 1000;     % msec
left_acc_x = left_acc_x(2:end); 
left_acc_y = left_acc_y(2:end); 
left_acc_z = left_acc_z(2:end); 
right_acc_fq = right_acc_x(1);              % Hz
right_acc_dt = 1 / right_acc_fq * 1000;     % msec
right_acc_x = right_acc_x(2:end); 
right_acc_y = right_acc_y(2:end); 
right_acc_z = right_acc_z(2:end);

%% Zero Pad
% The following lines of code zero pads the EDA and ACC data such that they
% both have the same length so we can make use of element wise matrix operation. 
% We zero pad based on the differences in start times.

% If the right signal starts after left, this will be positive
start_diff = (right_time_index(1) - left_time_index(1))/right_eda_dt;
start_diff_acc = (right_time_index(1) - left_time_index(1))/right_acc_dt;

% If the right signal ends after left, this will be positive
end_diff = (right_time_index(end) - left_time_index(end))/right_eda_dt;
end_diff_acc = (right_time_index(end) - left_time_index(end))/right_acc_dt;

if start_diff > 0
    global_start_time = left_time_index(1);
    right_eda = vertcat(zeros(abs(start_diff),1),right_eda);
    right_acc_x = vertcat(zeros(abs(start_diff_acc),1),right_acc_x);
    right_acc_y = vertcat(zeros(abs(start_diff_acc),1),right_acc_y);
    right_acc_z = vertcat(zeros(abs(start_diff_acc),1),right_acc_z);
elseif start_diff < 0
    global_start_time = right_time_index(1);
    left_eda = vertcat(zeros(abs(start_diff),1),left_eda);
    left_acc_x = vertcat(zeros(abs(start_diff_acc),1),left_acc_x);
    left_acc_y = vertcat(zeros(abs(start_diff_acc),1),left_acc_y);
    left_acc_z = vertcat(zeros(abs(start_diff_acc),1),left_acc_z);
end

if end_diff > 0
    global_end_time = right_time_index(end);
    left_eda = vertcat(left_eda, zeros(abs(end_diff),1));
    left_acc_x = vertcat(left_acc_x, zeros(abs(end_diff_acc),1));
    left_acc_y = vertcat(left_acc_y, zeros(abs(end_diff_acc),1));
    left_acc_z = vertcat(left_acc_z, zeros(abs(end_diff_acc),1));
elseif end_diff < 0
    global_end_time = left_time_index(end);
    right_eda = vertcat(right_eda, zeros(abs(end_diff),1));
    right_acc_x = vertcat(right_acc_x, zeros(abs(end_diff_acc),1));
    right_acc_y = vertcat(right_acc_y, zeros(abs(end_diff_acc),1));
    right_acc_z = vertcat(right_acc_z, zeros(abs(end_diff_acc),1));
end

% TODO: Remove need for extra zero padding; investigate the misalignment
if length(right_acc_x) > length(left_acc_x) 
    left_acc_x = vertcat(left_acc_x, zeros(abs(length(right_acc_x) - length(left_acc_x)),1));
    left_acc_y = vertcat(left_acc_y, zeros(abs(length(right_acc_y) - length(left_acc_y)),1));
    left_acc_z = vertcat(left_acc_z, zeros(abs(length(right_acc_y) - length(left_acc_z)),1));
elseif length(right_acc_x) < length(left_acc_x) 
    right_acc_x = vertcat(right_acc_x, zeros(abs(length(left_acc_x) - length(right_acc_x)),1));
    right_acc_y = vertcat(right_acc_y, zeros(abs(length(left_acc_y) - length(right_acc_y)),1));
    right_acc_z = vertcat(right_acc_z, zeros(abs(length(left_acc_z) - length(right_acc_z)),1));
end

 %% Preliminary Analysis
% The following lines of code calculate additional metrics that will
% be useful later for plotting

% Difference between left and right eda
net_eda = right_eda - left_eda;
net_eda_diff = diff(net_eda);

% Net ACC vector magnitude
left_acc = sqrt(left_acc_x.^2 + left_acc_y.^2 + left_acc_z.^2);
right_acc = sqrt(right_acc_x.^2 + right_acc_y.^2 + right_acc_z.^2);

% Difference between left and right acc
net_acc = right_acc - left_acc;
net_acc_diff = diff(net_acc);

% high pass filtered acc data
left_acc_hp = highpass_v1(left_acc, 8000, left_acc_dt);
right_acc_hp = highpass_v1(right_acc, 8000, right_acc_dt);
net_acc_hp = right_acc_hp - left_acc_hp;
net_acc_hp_diff = diff(net_acc_hp);

%clearvars 

end