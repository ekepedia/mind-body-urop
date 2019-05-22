function plotMeanWithRange(times, left_eda, right_eda, gst, dt)

leftmeans = [];
leftmaxes = [];
leftmins  = [];

rightmeans = [];
rightmaxes = [];
rightmins  = [];

trials = length(times);

% Gather Data By Trial
for i = 1:trials
    time_window = times(i,:);

    ts = round(timetoindex(char(time_window(1)), gst, dt));
    te = round(timetoindex(char(time_window(2)), gst, dt));
    
    left_scope = left_eda(ts:te);
    right_scope = right_eda(ts:te);
   
    leftmeans = [leftmeans, mean(left_scope)];
    leftmaxes = [leftmaxes, max(left_scope)];
    leftmins  = [leftmins,  min(left_scope)];
    
    rightmeans = [rightmeans, mean(right_scope)];
    rightmaxes = [rightmaxes, max(right_scope)];
    rightmins  = [rightmins,  min(right_scope)];
end

hold on
% Plot Left EDA
errorbar(1:trials, leftmeans, ...
    leftmeans - leftmins, leftmaxes - leftmeans,...
    'ob', "LineWidth", 1);


% Plot Right EDA
errorbar(1:trials, rightmeans, ...
    rightmeans - rightmins, rightmaxes - rightmeans,...
    'or', "LineWidth", 1);
hold off

end

