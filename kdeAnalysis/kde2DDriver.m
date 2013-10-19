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
qdMIP = getQDMaxIntensityProjection (controller, goodSlices, cellNumber);
qdMIPGray = mat2gray (qdMIP);
qdMIP_RGB = zeros (size (qdMIP, 1), size (qdMIP, 2), NUM_OF_DIMENSIONS);
qdMIP_RGB (:,:,1) = qdMIPGray;
qdMIP_RGB (:,:,3) = qdMIPGray;
qdMIP_RGB (:,:,2) = mat2gray (cellMembrane);
imagesc (qdMIP_RGB);

%plot 2D contour plot over RGB image
plotContourMap2D (separatedContourMatrix, numContours);

%display number QDs on 2D contour plot
pTextBox = uicontrol ('style', 'text');
set (pTextBox, 'Units', 'characters');
set (pTextBox, 'String', strcat ('# of QDs: ', {' '}, int2str (length (goodQDs))));
set (pTextBox, 'Position', [max(xlim)*0.1,min(ylim)+6,20,1.5]);

%plot 3D surface image
plot2DProbDensityEst_3D (xCoord, yCoord, probDensity);
