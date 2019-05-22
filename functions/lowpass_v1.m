% fn: LOW PASS FILTER
% decr: Low pass filter the data with a continous convolusion
% INPUTS
%   data - array of values 
%   width - size of window in milliseconds
%   dt - amount of time between array indexes
% RETURNS
%   lp - low passed filter data
function lp = lowpass_v1(data,width,dt)
width_steps = ceil(width / dt);              % convert from window to array indexes
kernel = ones(width_steps, 1) / width_steps; % set boxcar kernel
lp = conv(data, kernel, 'same');             % convolve data
end