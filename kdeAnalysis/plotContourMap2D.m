%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      plotContourMap2D
%
% Description: Plots each contour line using the plot () function. The
%              color of the contour line is determined by the normalized 
%              contour value.
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
XY_COORDS_LOCATION = 3;

NAVY_BLUE = [0, 0, 0.4000];
ORANGE = [1.0000, 0.6000, 0.0];
DARK_CYAN = [0, 0.8000, 1.0000];
HUNTER_GREEN = [0, 0.6000, 0];
LIME_GREEN = [0.6, 1.0, 0];
DARK_RED = [0.6500, 0, 0];
LINE_WIDTH = 2;

normContourValues = normalizeContourValues (getContourValues (separatedContourMatrix, numContours));

hold on 
for i = 1:numContours
    hPlot = plot (separatedContourMatrix{i, XY_COORDS_LOCATION}(:, X_COORD), separatedContourMatrix{i, XY_COORDS_LOCATION}(:, Y_COORD)); 
    
    set (hPlot, 'LineWidth', LINE_WIDTH);
    
    %bootstrap: if statements because cases won't
    %initiate in switch statement
    
    if (normContourValues(i) >= 0 && normContourValues(i) < 0.1)
            set (hPlot, 'Color', NAVY_BLUE)
    elseif (normContourValues(i) >= 0.1 && normContourValues(i) < 0.2)
            set (hPlot, 'Color', 'blue')
    elseif (normContourValues(i) >= 0.2 && normContourValues(i) < 0.3)
            set (hPlot, 'Color', DARK_CYAN)
    elseif (normContourValues(i) >= 0.3 && normContourValues(i) < 0.4)
            set (hPlot, 'Color', HUNTER_GREEN)
    elseif (normContourValues(i) >= 0.4 && normContourValues(i) < 0.5)
            set (hPlot, 'Color', 'green')
    elseif (normContourValues(i) >= 0.5 && normContourValues(i) < 0.6)
            set (hPlot, 'Color', LIME_GREEN)
    elseif (normContourValues(i) >= 0.6 && normContourValues(i) < 0.7)
            set (hPlot, 'Color', 'yellow')
    elseif (normContourValues(i) >= 0.7 && normContourValues(i) < 0.8)
            set (hPlot, 'Color', ORANGE)
    elseif (normContourValues(i) >= 0.8 && normContourValues(i) < 0.9)
            set (hPlot, 'Color', 'red')
    elseif (normContourValues(i) >= 0.9 && normContourValues(i) <= 1.0)
            set (hPlot, 'Color', DARK_RED)
    else
            set (hPlot, 'Color', 'black') %used for error checking i.e. if prev if statements did not evaluate to true
    end
end

hold off
colorbar;
xlabel ('x position (pixels)');
ylabel ('y position (pixels)');

end
