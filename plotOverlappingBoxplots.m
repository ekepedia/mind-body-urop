function plotOverlappingBoxplots(times, left_eda, right_eda, gst, dt)

leftdata = [];
leftgroups = [];

rightdata = [];
rightgroups = [];

trials = length(times);

% Gather Data By Trial
for i = 1:trials
    time_window = times(i,:);

    ts = round(timetoindex(char(time_window(1)), gst, dt));
    te = round(timetoindex(char(time_window(2)), gst, dt));
    
    left_scope = left_eda(ts:te);
    right_scope = right_eda(ts:te);
    
    indl = i*ones(length(left_scope), 1);
    leftdata = [leftdata; left_scope];
    leftgroups = [leftgroups; indl];
    
    indr = i*ones(length(right_scope), 1);
    rightdata = [rightdata; right_scope];
    rightgroups = [rightgroups; indr];
end

hold on

% Set the position to force plots to overlap
position = 1:1:25; 

% Plot Left Boxplot
leftbx = boxplot(leftdata, leftgroups, 'colors', 'b', 'positions', position);
set(leftbx,{'linew'},{0.6})

% Plot Right Boxplot
rightbx = boxplot(rightdata, rightgroups, 'colors', 'r', 'positions', position);
set(rightbx,{'linew'},{0.6})

hold off

end

