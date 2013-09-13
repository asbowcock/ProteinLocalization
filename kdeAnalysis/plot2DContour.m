%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:    plot2DContour
% Description: Produces a 2D contour plot. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [contourPlot, pContourPlot] = plot2DContour( xCoord, yCoord, probDensity, xAxisTitle, yAxisTitle, graphTitle )

X_MIN = -20;
X_MAX = 250;
Y_MIN = -20;
Y_MAX = 250;

[contourPlot, pContourPlot] = contour (xCoord, yCoord, probDensity);
colorbar ();
xlabel (xAxisTitle);
ylabel (yAxisTitle);
title (graphTitle);
axis ij;
axis ([X_MIN, X_MAX, Y_MIN, Y_MAX]);
end

