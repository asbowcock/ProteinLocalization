%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script:      kde2DDriver
% Description: Produces a probability density estimate contour plot based
%              on x and y coordinates of QDs. The contour plot is overlayed
%              on the grayscale image of the nucleus. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xyCoords = getXYCoords (getFinalQDPoints (controller));

for i = 106:length (xyCoords)
    
    [bandwidth, probDensity, xCoord, yCoord] = kde2d (xyCoords(1:i,:));

    figure ('visible', 'off'); 

    contourMatrix = contour (xCoord, yCoord, probDensity);

    figure ('visible', 'on');
    
    dataNucleusMIP = controller.dataNuc{1}.data (:,:,goodSlices{1}(1):goodSlices{1}(2));
    dataNucleusMIP = max (dataNucleusMIP, [], 3);
    cellNucImage = imagesc (dataNucleusMIP);
    set (cellNucImage, 'AlphaData', 1);
    colormap (gray);

%{
dataQDMIP = controller.dataQD{1}.data (:,:,4:21);
dataQDMIP = max (dataQDMIP, [], 3);
imagesc (dataQDMIP);
colormap (gray);
%}

%{
dataCellMembraneMIP = controller.cellData{1}.data (:,:,4:21);
dataCellMembraneMIP = max (dataCellMembraneMIP, [], 3);
cellMembraneImage = imagesc (dataCellMembraneMIP);
set (cellMembraneImage, 'AlphaData', 0.5);
%colormap (gray);
%}

    contourMatrix = contourMatrix';

    separateContourMatrix;

    xlabel ('x (pixels)');
    ylabel ('y (pixels)');
    
    print ('-dtiff', '-r500','testFigureTiff500'); 
end