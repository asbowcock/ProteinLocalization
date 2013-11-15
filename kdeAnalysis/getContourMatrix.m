%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      getContourMatrix
%
% Description: Returns the contour matrix for the probability density of 
%              the quantum dots in a cell. The contour matrix contains 
%              NUM_CONTOURS contour lines with respective contour values
%              and associated x,y coordinates.
%
% Parameters:  xCoord      - the x-coordinates of the QDs 
%              yCoord      - the y-coordinates of the QDs
%              probDensity - the probability denisity of the QDs
%
% Returned:    The contour matrix for the probability density of the QDs in
%              the cell.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ contourMatrix ] = getContourMatrix (xCoord, yCoord, probDensity)

figure ('visible', 'off');

contourMatrix = contour (xCoord, yCoord, probDensity, NUM_CONTOURS);

figure ('visible', 'on');

end

