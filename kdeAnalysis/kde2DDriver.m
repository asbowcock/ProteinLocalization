%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script:      kde2DDriver
% 
% Description: Calculates and displays the two dimensional probability
%              density estimate for all identified quantum dots in a cell.
%              The probability density estimate is plotted as a
%              contour plot based on x and y coordinates of QDs. The 
%              contour plot is overlayed on an RGB image of the cell 
%              membrane (green) and QDs(magenta). The probability density 
%              estimate is also plotted as a three dimensional surface
%              plot.
%
% Parameters:  None
%
% Returned:    None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Constants  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NUM_OF_DIMENSIONS = 3;
GAMMA = 0.5;
NUM_QDS_X_POSITION = 0.7;
NUM_QDS_Y_POSITION = 0.07;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cellNumber = 1;

%Calculate the probability density estimate
goodQDs = findGoodQDs (controller, cellNumber);
xyCoords = getXYCoords (getSelectedQDsXYZCoords (controller, cellNumber, goodQDs));

[bandwidth, probDensity, xCoord, yCoord] = kde2d (xyCoords(1:length (goodQDs),:));

%Parse the contour matrix in preparation for plotting the 2D contour plot
contourMatrix = getContourMatrix (xCoord, yCoord, probDensity);
contourMatrix = contourMatrix';
[separatedContourMatrix, numContours] = separateContourMatrix (contourMatrix);

%create and display RGB image of QD MIP and cell membrane
cellMembrane = controller.cellData{cellNumber}.data(:,:,floor (median (goodSlices{cellNumber})));
nucMembrane = controller.dataNuc{cellNumber}.data(:,:,floor (median (goodSlices{cellNumber})));
qdMIP = getQDMaxIntensityProjection (controller, goodSlices, cellNumber);
qdMIPGray = mat2gray (qdMIP);
overlayRGB = zeros (size (qdMIP, 1), size (qdMIP, 2), NUM_OF_DIMENSIONS);
%overlayNucRGB = zeros (size (nucMembrane, 1), size (nucMembrane, 2), NUM_OF_DIMENSIONS);
overlayRGB (:,:,1) = imadjust (qdMIPGray);
overlayRGB (:,:,3) = imadjust (qdMIPGray);
overlayRGB (:,:,2) = imadjust (mat2gray (cellMembrane),[], [], GAMMA);
%overlayNucRGB (:,:,2) = imadjust (mat2gray (nucMembrane),[], [], GAMMA);
imagesc (overlayRGB);

%{
hold on; 
hNucRGB = imagesc (overlayNucRGB);
set (hNucRGB, 'AlphaData', 0.5);
hold off;
%}

%plot 2D contour plot over RGB image
plotContourMap2D (separatedContourMatrix, numContours);

%display number of QDs on 2D contour plot
hTextBox = annotation ('textbox', [NUM_QDS_X_POSITION, NUM_QDS_Y_POSITION, 0, 0]);
set (hTextBox, 'FitBoxToText', 'on');
set (hTextBox, 'String', strcat ('Number of QDs: ', {' '}, int2str (length (goodQDs))));

%plot 3D surface image
plot2DProbDensityEst_3D (xCoord, yCoord, probDensity);
