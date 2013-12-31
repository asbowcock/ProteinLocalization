function [binSize] = getBinSize (xCoord, yCoord)

binSize = zeros (1,2);
binSize (1) = xCoord (1, 1) - xCoord (1, 2);
binSize (2) = yCoord (1, 1) - yCoord (2, 1);
 
end

