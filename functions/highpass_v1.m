% fn: HIGH PASS FILTER
% decr: High pass filter the data with a continous convolusion
% INPUTS
%   data - array of values 
%   width - size of window in milliseconds
%   dt - amount of time between array indexes
% RETURNS
%   hp - high passed filter data
function hp = highpass_v1(data,width,dt)
width_steps = ceil(width / dt);               % convert from window to array indexes
kernel = -ones(width_steps, 1) / width_steps; % set invert boxcar kernel
kernel(round(length(kernel)/2)) = 1;          % set middle value to one
hp = conv(data, kernel, 'same');              % convolve data
end

