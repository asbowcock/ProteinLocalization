%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      getXYCoords
%
% Description: Returns the x and y coordinates from an array containing x,
%              y, and z coordinates.
%
% Parameters:  xyzCoords - an array containing x, y, and z coordinates
%
% Returned:    The x and y coordinates contained in the array
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [xyCoords] = getXYCoords (xyzCoords)

X_COORD = 1;
Y_COORD = 2;

xyCoords = [xyzCoords(:,X_COORD), xyzCoords(:,Y_COORD)];

end

