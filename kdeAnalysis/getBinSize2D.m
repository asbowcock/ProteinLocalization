%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      getBinSize2D
%
% Description: Gets the bin size (change in coordinate value) for the two
%              passed in coordinate vectors
%
% Parameters:  xCoord - x-coordinate vector
%              yCoord - y-coordinate vector
%          
% Returned:    the bin size for each coordinate vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [binSize2D] = getBinSize2D (xCoord, yCoord)

X_COORD = 1;
Y_COORD = 2;

binSize2D (X_COORD) = getBinSize (xCoord);
binSize2D (Y_COORD) = getBinSize (yCoord);

end
