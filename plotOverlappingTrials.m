function plotOverlappingTrials (times, data, gs, dt)

M = 25;
subplot(1,2,1)
hold on
colormap = jet(25);
for i = 1:M
    time_window = times(i,:);

    ts = round(timetoindex(char(time_window(1)), gs, dt));
    te = round(timetoindex(char(time_window(2)), gs, dt));

    eda_scope = data(ts:te);
    
    mu = mean(eda_scope);
    sd = std(eda_scope);
    
    color = colormap(i,:);
    
    plot(eda_scope, "Color", color)
    
end
hold off
default_format(gca, "Original", sprintf("Time Since Trial Start (%dms)", dt), "Conductance \muS");

subplot(1,2,2)
hold on
for i = 1:M
    time_window = times(i,:);

    ts = round(timetoindex(char(time_window(1)), gs, dt));
    te = round(timetoindex(char(time_window(2)), gs, dt));

    eda_scope = data(ts:te);
    
    mu = mean(eda_scope);
    sd = std(eda_scope);
    
    color = colormap(i,:);
    
    plot((eda_scope- mu) / sd, "Color", color)
    
end
hold off
default_format(gca, "Z-Score", sprintf("Time Since Trial Start (%dms)", dt), "Conductance \muS");

legend('Location','bestoutside');

labels = [];
for i = 1:M
    labels = [labels, sprintf("Trail %d",i)];
end

legend(labels)

% Construct a Legend with the data from the sub-plots
hL = legend(labels);
% Programatically move the Legend
newPosition = [0.85 0.4 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
end