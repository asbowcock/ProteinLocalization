%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script:      kde2DDriver
% Description: Produces a probability density estimate contour plot based
%              on x and y coordinates of QDs. The contour plot is overlayed
%              on the grayscale image of the nucleus. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xyCoords = getXYCoords (getFinalQDPoints (controller));

[bandwidth, probDensity, xCoord, yCoord] = kde2d (xyCoords);

figure ('visible', 'off'); 

contourMatrix = contour (xCoord, yCoord, probDensity);

figure ('visible', 'on');


dataNucleusMIP = controller.dataNuc{1}.data (:,:,4:21);
dataNucleusMIP = max (dataNucleusMIP, [], 3);
cellImage = imagesc (dataNucleusMIP);
set (cellImage, 'AlphaData', 1);
colormap (gray);

%{
dataQDMIP = controller.dataQD{1}.data (:,:,4:21);
dataQDMIP = max (dataQDMIP, [], 3);
imagesc (dataQDMIP);
colormap (gray);
%}
contourMatrix = contourMatrix';

separateContourMatrix;

xlabel ('x (pixels)');
ylabel ('y (pixels)');
