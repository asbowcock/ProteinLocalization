%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:    kde2DDriver
% 
% Version:     1.2
%
% Description: Calculates and displays the two dimensional probability
%              density estimate for identified quantum dots in a cell.
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
LOWER_BOUND = -1000000; %nanometers
UPPER_BOUND = 1000000; %nanometers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Calculate the probability density estimate
goodQDs = findGoodQDs (controller, cellNumber);
selectQDs = selectQDsWithinRange (controller.distQDtoMembrane{cellNumber}(goodQDs), LOWER_BOUND, UPPER_BOUND);
xyCoords = getXYCoords (getSelectedQDsXYZCoords (controller, cellNumber, selectQDs));

[bandwidth, probDensity, xCoord, yCoord] = kde2d (xyCoords(:,:));

%probDensity = normalizePDE (probDensity);

%Parse the contour matrix in preparation for plotting the 2D contour plot
contourMatrix = getContourMatrix (xCoord, yCoord, probDensity);
contourMatrix = contourMatrix';
[separatedContourMatrix, numContours] = separateContourMatrix (contourMatrix);

%create and display RGB image of QD MIP, cell membrane, and nuclear membrane
overlayRGB = createRGBImageCellMemNucMemQD (controller, goodSlices, cellNumber);
imagesc (overlayRGB);

%plot contour map of 2D PDE over RGB image
plotContourMap2D (separatedContourMatrix, numContours);

%display number of QDs on 2D contour plot
displayNumberQDs (length (selectQDs));

%plot 3D surface image
plot2DProbDensityEst_3D (xCoord, yCoord, probDensity);

end

