function plotAllTrials (times, left_eda, right_eda, gst, dt, ylimit)

for i = 1:25
    subplot(5,5,i);
    time_window = times(i,:);

    ts = round(timetoindex(char(time_window(1)), gst, dt));
    te = round(timetoindex(char(time_window(2)), gst, dt));
    
    hold on
    if exist('left_eda','var') && ~isempty(left_eda)
        plot(left_eda(ts:te), "b");
    end
    if exist('right_eda','var') && ~isempty(right_eda)
        plot(right_eda(ts:te), "r");
    end
    hold off
    
    if exist('ylimit','var')
        ylim(ylimit);
    end
    
    title(sprintf("Trial %d", i));
end

end

