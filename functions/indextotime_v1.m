% fn: INDEX TO TIME
% decr: Convert from index in array to a timestamp
% INPUTS
%   index - index in the array
%   start - start time of the array
%   dt - amount of time between array indexes
% RETURNS
%   t - time stamp formatted "HH:MM:SS"
function t = indextotime_v1(index, start, dt)
conversion = 24 * 60 *60 * 1000;

time_since_start = index * dt;                % convert from index to time since t = 0
date = time_since_start + start;              % convert from time since t = 0 to milliseconds
time = datestr(date/conversion, "HH:MM:SS");  % convert from milliseconds to time string

t = time;
end