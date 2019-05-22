function default_format(chart, t, x, y)
    title(t);
    xlabel(x);
    ylabel(y);
    chart.FontSize = 14;
    chart.LineWidth = 1;
    box off
end