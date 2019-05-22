% fn: TIME TO INDEX
% decr: Convert from timestamp to index in array
% INPUTS
%   time - time stamp formatted "HH:MM:SS"
%   start - start time of the array
%   dt - amount of time between array indexes
% RETURNS
%   ei - index in the eda array
%   ai - index in the acc array
function [ei, ai] = timetoindex(time, start, dt)
conversion = 24 * 60 *60 * 1000;

date = datenum(time) * conversion;   % convert from time string to milliseconds
time_since_start = date - start;     % convert milliseconds to time since t = 0

time_index = time_since_start / dt;  % convert into array index
ei = time_index;

ai = time_index;

end