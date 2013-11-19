%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:    kde2DUserImageDriver
% 
% Version:     1.0
%
% Description: Calculates and displays the two dimensional probability
%              density estimate for identified quantum dots in a cell.
%              The probability density estimate is plotted as a
%              contour plot based on x and y coordinates of QDs. The 
%              contour plot is overlaid on an image selected by the user.
%              The probability density estimate is also plotted as a three 
%              dimensional surface plot.
%
% Parameters:  controller - the controller object 
%              cellNumber - the particular cell to be analyzed
%
% Returned:    None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function kde2DUserImageDriver (controller, cellNumber)

% Calculate the probability density estimate

xyCoords = getXYCoords (controller.dataQD{cellNumber}{1}.SuperQD);

[bandwidth, probDensity, xCoord, yCoord] = kde2d (xyCoords(:,:));

% resize x,y-coordinates so that PDE overlays on appropriate section of 
% user selected input image (see below)
resizeParameters = controller.maskBox{cellNumber}.getPosition;
xCoord = xCoord + resizeParameters(1);
yCoord = yCoord + resizeParameters(2);

% Parse the contour matrix in preparation for plotting the 2D contour plot
contourMatrix = getContourMatrix (xCoord, yCoord, probDensity);
contourMatrix = contourMatrix';
[separatedContourMatrix, numContours] = separateContourMatrix (contourMatrix);

% Read in image that PDE will be overlaid on
inputFile = uigetfile ('*.tif');

if (0 == inputFile)
    close (gcf);
    error ('Failed to open file');
end

img = imread (inputFile);
imagesc (img);

%plot contour map of 2D PDE over RGB image

plotContourMap2D (separatedContourMatrix, numContours);

%display number of QDs on 2D contour plot
displayNumberQDs (length (xyCoords));

%plot 3D surface image
plot2DProbDensityEst_3D (xCoord, yCoord, probDensity);

end

