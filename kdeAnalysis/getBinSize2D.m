function [binSize2D] = getBinSize2D (xCoord, yCoord)

X_COORD = 1;
Y_COORD = 2;

binSize2D (X_COORD) = getBinSize (xCoord);
binSize2D (Y_COORD) = getBinSize (yCoord);

end

