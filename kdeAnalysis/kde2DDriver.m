%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script:      kde2DDriver
% Description: Produces a probability density estimate contour plot based
%              on x and y coordinates of QDs
%Selects the x and y coordinates from the input data and then
%              selects a pseudo-random sub-sample from those coordinates. 
%              The probability density for that sub-sample is then created 
%              and returned with the probability density bandwidth and 2D 
%              coordinates.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global NUM_XY_COORDS;
NUM_XY_COORDS = 100;
NUM_DATA_POINTS = 20;
bIsNoise = false;

%artificialData = createArtificialData (NUM_DATA_POINTS, bIsNoise);
%xyCoords = getXYCoords (artificialData{1});

xyCoords = getXYCoords (getFinalQDPoints (controller));

%xyCoordsRandSample = datasample (xyCoords, NUM_XY_COORDS, 'Replace', false);

[bandwidth, probDensity, xCoord, yCoord] = kde2d (xyCoords);

%[xCoord, yCoord, probDensity] = createNormProbDensity (xyCoords);

%[contourMatrix, pContourPlot] = plot2DContour (xCoord, yCoord, probDensity, 'x (pixel)', 'y (pixel)', 'Probability Density Estimate for Exp. 4.11 Cell 1');

figure ('visible', 'off'); 

contourMatrix = contour (xCoord, yCoord, probDensity);

figure ('visible', 'on');

%{
dataNucleusMIP = controller.dataNuc{1}.data (:,:,4:21);
dataNucleusMIP = max (dataNucleusMIP, [], 3);
cellImage = imagesc (dataNucleusMIP);
set (cellImage, 'AlphaData', 1);
colormap (gray);
%}

dataQDMIP = controller.dataQD{1}.data (:,:,4:21);
dataQDMIP = max (dataQDMIP, [], 3);
imagesc (dataQDMIP);

contourMatrix = contourMatrix';

separateContourMatrix;

xlabel ('x (pixels)');
ylabel ('y (pixels)');
