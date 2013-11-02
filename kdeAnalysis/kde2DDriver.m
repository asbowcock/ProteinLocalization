%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script:      kde2DDriver
% 
% Version:     1.1
%
% Description: Calculates and displays the two dimensional probability
%              density estimate for all identified quantum dots in a cell.
%              The probability density estimate is plotted as a
%              contour plot based on x and y coordinates of QDs. The 
%              contour plot is overlayed on an RGB image of the cell 
%              membrane (green), nuclear membrane (green), and QDs(magenta).
%              The probability density estimate is also plotted as a three 
%              dimensional surface plot.
%
% Parameters:  controller - the controller object 
%              goodSlice  - the good slices from the cell containing the
%                           QDs
%              cellNumber - the particular cell to be analyzed
%
% Returned:    None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function kde2DDriver(controller, goodSlices, cellNumber)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Constants  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NUM_OF_DIMENSIONS = 3;
GAMMA = 0.5;
NUM_QDS_X_POSITION = 0.7;
NUM_QDS_Y_POSITION = 0.07;
LOWER_BOUND = -1000; %nanometers
UPPER_BOUND = 1000000; %nanometers
RED_CHANNEL = 1;
GREEN_CHANNEL = 2;
BLUE_CHANNEL = 3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Calculate the probability density estimate
goodQDs = findGoodQDs (controller, cellNumber);
selectQDs = selectQDsWithinRange (controller.distQDtoMembrane{cellNumber}(goodQDs), LOWER_BOUND, UPPER_BOUND);
xyCoords = getXYCoords (getSelectedQDsXYZCoords (controller, cellNumber, selectQDs));

[bandwidth, probDensity, xCoord, yCoord] = kde2d (xyCoords(:,:));

%Parse the contour matrix in preparation for plotting the 2D contour plot
contourMatrix = getContourMatrix (xCoord, yCoord, probDensity);
contourMatrix = contourMatrix';
[separatedContourMatrix, numContours] = separateContourMatrix (contourMatrix);

%create and display RGB image of QD MIP, cell membrane, and nuclear membrane
cellMembrane = controller.cellData{cellNumber}.data(:,:,floor (median (goodSlices{cellNumber})));
nucMembrane = controller.dataNuc{cellNumber}.data(:,:,floor (median (goodSlices{cellNumber})));
qdMIP = getQDMaxIntensityProjection (controller, goodSlices, cellNumber);
qdMIPGray = mat2gray (qdMIP);
overlayRGB = zeros (size (qdMIP, 1), size (qdMIP, 2), NUM_OF_DIMENSIONS);
overlayRGB (:,:,RED_CHANNEL) = imadjust (qdMIPGray);
overlayRGB (:,:,BLUE_CHANNEL) = imadjust (qdMIPGray);
overlayRGB (:,:,GREEN_CHANNEL) = imadjust (mat2gray (cellMembrane) + mat2gray (nucMembrane),[], [], GAMMA);
imagesc (overlayRGB);

%plot 2D contour plot over RGB image
plotContourMap2D (separatedContourMatrix, numContours);

%display number of QDs on 2D contour plot
hTextBox = annotation ('textbox', [NUM_QDS_X_POSITION, NUM_QDS_Y_POSITION, 0, 0]);
set (hTextBox, 'FitBoxToText', 'on');
set (hTextBox, 'String', strcat ('Number of QDs: ', {' '}, int2str (length (selectQDs))));

%plot 3D surface image
plot2DProbDensityEst_3D (xCoord, yCoord, probDensity);

end

