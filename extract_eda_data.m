function [ global_start_time, left_eda, right_eda, left_eda_dt, right_eda_dt ] = extract_eda_data (left_eda_filename,right_eda_filename,left_eda_start_filename,right_eda_start_filename) 

addpath("./functions");

%% Open files
% The follwing lines of code specify the files used in this script. Note folder strucutre

left_eda_file = fopen(left_eda_filename);
right_eda_file = fopen(right_eda_filename);
left_eda_start_file = fopen(left_eda_start_filename);
right_eda_start_file = fopen(right_eda_start_filename);

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

%% Zero Pad
% The following lines of code zero pads the EDA and ACC data such that they
% both have the same length so we can make use of element wise matrix operation. 
% We zero pad based on the differences in start times.

% If the right signal starts after left, this will be positive
start_diff = (right_time_index(1) - left_time_index(1))/right_eda_dt;

% If the right signal ends after left, this will be positive
end_diff = (right_time_index(end) - left_time_index(end))/right_eda_dt;

if start_diff > 0
    global_start_time = left_time_index(1);
    right_eda = vertcat(zeros(abs(start_diff),1),right_eda);
elseif start_diff < 0
    global_start_time = right_time_index(1);
    left_eda = vertcat(zeros(abs(start_diff),1),left_eda);
end

if end_diff > 0
    global_end_time = right_time_index(end);
    left_eda = vertcat(left_eda, zeros(abs(end_diff),1));
elseif end_diff < 0
    global_end_time = left_time_index(end);
    right_eda = vertcat(right_eda, zeros(abs(end_diff),1));
end

end