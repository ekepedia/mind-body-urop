function scaleFigure(f, xs, ys)
set(f, 'PaperUnits', 'inches');
x_width = 7.25*xs; y_width = 9.125*ys;
set(f, 'PaperPosition', [0 0 x_width y_width]); 
end

