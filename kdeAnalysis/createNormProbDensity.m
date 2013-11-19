function [ xCoord, yCoord, probDensity ] = createNormProbDensity( xyCoords )
%CREATENORMPROBABILITYDENSITY Summary of this function goes here
%   Detailed explanation goes here

xCoord = xyCoords(:, 1);
yCoord = xyCoords(:, 2);

[xCoordGrid, yCoordGrid] = meshgrid (xCoord, yCoord);
 probDensity = mvnpdf ([xCoordGrid(:), yCoordGrid(:)]);
 probDensity = reshape (probDensity, length (xCoord), length (yCoord));

end

