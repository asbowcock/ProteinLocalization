function [ contourMatrix ] = getContourMatrix (xCoord, yCoord, probDensity)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
figure ('visible', 'off');

contourMatrix = contour (xCoord, yCoord, probDensity);

figure ('visible', 'on');

end

