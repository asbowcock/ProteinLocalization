%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script:      kde2DDriver
% 
% Description: Produces a probability density estimate contour plot based
%              on x and y coordinates of QDs. The contour plot is overlayed
%              on the grayscale image of the nucleus. 
%
% Parameters:  None
%
% Returned:    None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cellNumber = 1;

goodQDs = findGoodQDs (controller, cellNumber);
xyCoords = getXYCoords (getSelectedQDsXYZCoords (controller, cellNumber, goodQDs));

[bandwidth, probDensity, xCoord, yCoord] = kde2d (xyCoords(1:length (goodQDs),:));

contourMatrix = getContourMatrix (xCoord, yCoord, probDensity);

contourMatrix = contourMatrix';

[separatedContourMatrix, numContours] = separateContourMatrix (contourMatrix);

cellMembrane = controller.cellData{1}.data(:,:,floor (median (goodSlices{1})));

qdMIP = getQDMaxIntensityProjection (controller, goodSlices, 1);
qdMIPGray = mat2gray (qdMIP);
qdMIP_RGB = zeros (size (qdMIP, 1), size (qdMIP, 2), 3);
qdMIP_RGB (:,:,1) = qdMIPGray;
qdMIP_RGB (:,:,3) = qdMIPGray;
qdMIP_RGB (:,:,2) = mat2gray (cellMembrane);
imagesc (qdMIP_RGB);

%{
cellMembraneMIP = getCellMembraneMIP (controller, goodSlices, 1);
cellMembraneMIPGray = mat2gray (cellMembraneMIP);
cellMembraneMIP_RGB = zeros (size (cellMembraneMIPGray, 1), size (cellMembraneMIPGray, 2), 3);
cellMembraneMIP_RGB (:,:,2) = cellMembraneMIPGray;
hQD = imagesc (qdMIP_RGB);
hold on
hCM = imagesc (cellMembraneMIP_RGB);
set (hCM, 'AlphaData', 0.5);
hold off
%}

plotContourMap2D (separatedContourMatrix, numContours);

pTextBox = uicontrol ('style', 'text');

set (pTextBox, 'Units', 'characters');
set (pTextBox, 'String', strcat ('# of QDs: ', {' ' }, int2str (length (goodQDs))));
set (pTextBox, 'Position', [115,6,25,1.5]);

%plot2DProbDensityEst_3D (xCoord, yCoord, normalizePDE (probDensity));

%{
cellNumber = 1;

xyCoords = getXYCoords (getFinalQDPoints (controller, cellNumber));

for i = length (xyCoords):length (xyCoords)
    
    [bandwidth, probDensity, xCoord, yCoord] = kde2d (xyCoords(1:i,:));
    
    contourMatrix = getContourMatrix (xCoord, yCoord, probDensity);
    
    dataNucleusMIP = controller.dataNuc{cellNumber}.data (:,:,goodSlices{cellNumber}(1):goodSlices{cellNumber}(2));
    dataNucleusMIP = max (dataNucleusMIP, [], 3);
    cellNucImage = imagesc (dataNucleusMIP);
    set (cellNucImage, 'AlphaData', 1);
    colormap (gray);
    
    %{
    dataQDMIP = controller.dataQD{1}.data (:,:,goodSlices{1}(1):goodSlices{1}(2));
    dataQDMIP = max (dataQDMIP, [], 3);
    imagesc (dataQDMIP);
    colormap (gray);
    %}

    %{
    dataCellMembraneMIP = controller.cellData{1}.data (:,:,goodSlices{1}(1):goodSlices{1}(2));
    dataCellMembraneMIP = max (dataCellMembraneMIP, [], 3);
    cellMembraneImage = imagesc (dataCellMembraneMIP);
    set (cellMembraneImage, 'AlphaData', 1);
    colormap (gray);
    %}
    contourMatrix = contourMatrix';

    separateContourMatrix;

    xlabel ('x (pixels)');
    ylabel ('y (pixels)');
    
    pTextBox = uicontrol ('style', 'text');

    set (pTextBox, 'Units', 'characters');
    set (pTextBox, 'String', strcat ('Number of QDs: ', i));
    
    %print ('-dpng', '-r500','testFigureTiff500'); 
end
%}