%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      plotContourMap2D
%
% Description: Plots each contour line using the plot () function. The
%              color of the contour line is determined by the contour 
%              value.
%
% Parameters:  separatedContourMatrix - a separated contour matrix
%                                       containing the contour value, the
%                                       number of x,y-coordinates
%                                       associated with the contour value,
%                                       and a matrix of the x,
%                                       y-coordinates
%              numContours            - number of contours to plot
%
% Returned:    None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plotContourMap2D (separatedContourMatrix, numContours)

X_COORD = 1;
Y_COORD = 2;
CONTOUR_VALUE_LOCATION = 1;
XY_COORDS_LOCATION = 3;

hold on 
for i = 1:numContours
    hPlot = plot (separatedContourMatrix{i, XY_COORDS_LOCATION}(:, X_COORD), separatedContourMatrix{i, XY_COORDS_LOCATION}(:, Y_COORD)); 
    
    %bootstrap: if statements because cases won't
    %initiate in switch statement
    
    if separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} > 0 && separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} < 0.00002
        set (hPlot, 'Color', 'blue');
    end
    
    if separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} > 0.00001 && separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} < 0.00003
        set (hPlot, 'Color', 'cyan');
    end
    
    if separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} > 0.00002 && separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} < 0.00004
        set (hPlot, 'Color', 'green');
    end
    
    if separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} > 0.00003 && separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} < 0.00005
        set (hPlot, 'Color', 'yellow');
    end
    
    if separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} > 0.00004 && separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} < 0.00006
        set (hPlot, 'Color', [0.75, 0.1608, 0]);
    end
    
    if separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} > 0.00005 && separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} < 0.00007
        set (hPlot, 'Color', 'red');
    end
    
end
hold off


end

