function plot_rects(times, color)

for index = 1:length(times)

    time = times(index,:);
    x1 = datetime(char(time(1)));
    x2 = datetime(char(time(2)));

    Ys = ylim;
    Y1 = [Ys(1),Ys(2),Ys(2),Ys(1)]; 
    ptch = fill([x1 x1 x2 x2], Y1, color);
    alpha(0.15)
    ptch.FaceAlpha = .15;
    
end

end