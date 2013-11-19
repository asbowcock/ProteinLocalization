%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:    analyzeQDLocation
% Description: Selects the x and y coordinates from the input data and then
%              selects a pseudo-random sub-sample from those coordinates. 
%              The probability density for that sub-sample is then created 
%              and returned with the probability density bandwidth and 2D 
%              coordinates. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [bandwidth, probDensity, xCoord, yCoord] = analyzeQDLocation( xyzCoords )

global NUM_XY_COORDS;

xyCoords = [xyzCoords{1}(:,1), xyzCoords{1}(:,2)];

xyCoordsRandSample = datasample (xyCoords, NUM_XY_COORDS, 'Replace', false);

[bandwidth, probDensity, xCoord, yCoord] = kde2d (xyCoordsRandSample);

end

