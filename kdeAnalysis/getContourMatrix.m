%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      getContourMatrix
%
% Description: Returns the contour matrix for the probability density of 
%              the quantum dots in a cell.
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

