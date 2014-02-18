%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:    pde2DDriver
% 
% Version:     1.3
%
% Description: Calculates and displays the two dimensional probability
%              density estimate (PDE) for identified quantum dots in a cell.
%              The probability density estimate is plotted as a
%              contour plot based on x and y coordinates of QDs. The 
%              contour plot is overlayed on an RGB image of the cell 
%              membrane (green), nuclear membrane (green), and QDs(magenta).
%              The probability density estimate is also plotted as a three 
%              dimensional surface plot. The probability is also calculated
%              for a region centered around the maximum PDE value;
%              the size of the region is specified by the user. The PDE
%              values, x-coordinates, y-coordinates, and probability value
%              is saved to a .mat file. The contour plot and 3D surface
%              plot are also saved to image files.
%
%              Example:
%              outputPDEDataFile = 'C:\Users\Person\Desktop\data';
%              outputContourPlotFile =
%                                'C:\Users\Person\Desktop\contourPlot.fig';
%              output3DPlotFile = 'C:\Users\Person\Desktop\threeDPlot.fig';
%              inputData = randn (50, 2);
%              imageFile = 'C:\Users\Person\Desktop\overlayImage.tif';
%
%              pde2DDriver (outputPDEDataFile, outputContourPlotFile,
%              output3DPlotFile, inputData, 'imageFile', imageFile);
%
% Parameters:  outputPDEDataFile     - the file name where the PDE values,
%                                      x-coordiantes, y-coordinates, and 
%                                      the probability value will be saved
%              outputContourPlotFile - the file name for the contour plot
%                                      image
%              output3DPlotFile      - the file name for the 3D surface
%                                      plot
%              inputData             - either a .mat file from the Membrane
%                                      GUI program or a n-by-2 array of the
%                                      x- and y-coordinates of the QDs
% 
% Optional Parameters: in this function call, after entering the above 
%                      arguments, enter parameter name as string followed 
%                      by a comma and then the value; see the example above
%              
%              cellNumber   - for use when passing .mat file with more than 
%                             one cell's data; the particular cell data to 
%                             use; the default is 1
%              imageFile    - the file name of the overlay image
%              overlayShift - a 1-by-2 matrix that shifts the
%                             x,y-coordinates of the PDE so the PDE
%                             overlays with the appropriate section of
%                             the image; the first element is the
%                             x-coordinate shift; the second element is
%                             the y-coordinate shift; the default is [0,0]
%              regionSize   - a scaler giving the size of a square region 
%                             over which the probability will be 
%                             calculated; the size refers to the number of 
%                             PDE values; the default is 4
%
% Returned:    None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function pde2DDriver (outputPDEDataFile, outputContourPlotFile, ...
                      output3DPlotFile, inputData, varargin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Constants  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LOWER_BOUND = -1000; %nanometers
UPPER_BOUND = 1000000; %nanometers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize input parser
theInputParser = inputParser;
theInputParser = initializeInputParser (theInputParser);
theInputParser.parse (outputPDEDataFile, outputContourPlotFile, ...
                      output3DPlotFile, inputData, varargin{:});

bHasImage = true;
                  
% If .mat file has been passed in
if (ischar (theInputParser.Results.inputData))
    
    load (theInputParser.Results.inputData);

    goodQDs = findGoodQDs (controller, theInputParser.Results.cellNumber);
    selectQDs = selectQDsWithinRange (controller.distQDtoMembrane{...
        theInputParser.Results.cellNumber}(goodQDs), ...
        LOWER_BOUND, UPPER_BOUND);
    xyCoords = getXYCoords (getSelectedQDsXYZCoords (controller, ...
                            theInputParser.Results.cellNumber, selectQDs));
    
    % No image file passed in, so use image in controller class
    if (strcmp (theInputParser.Results.imageFile, ''))
        overlayRGB = createRGBImageCellMemNucMemQD (controller, ...
                                                    goodSlices, ...
                                        theInputParser.Results.cellNumber);
    else
        overlayRGB = imread (theInputParser.Results.imageFile);
    end
% If array of x,y-coordinates has been passed in    
else
    xyCoords = theInputParser.Results.inputData;
    
    if (strcmp (theInputParser.Results.imageFile, ''))
        bHasImage = false;
    else
        overlayRGB = imread (theInputParser.Results.imageFile);
    end
end

% Error checks for valid number of probes
if ~checkValidNumOfProbes (length (xyCoords)) 
    errorMsgInvalidNumOfProbes = ERROR_MSG_INVALID_NUM_OF_PROBES;
    error (errorMsgInvalidNumOfProbes{1});
end

% Calculate the probability density estimate
[bandwidth, pde, xCoord, yCoord] = kde2d (xyCoords);

xCoord = xCoord + theInputParser.Results.overlayShift(1);
yCoord = yCoord + theInputParser.Results.overlayShift(2); 

% Parse the contour matrix in preparation for plotting the 2D contour plot
contourMatrix = getContourMatrix (xCoord, yCoord, pde);
contourMatrix = contourMatrix';
[separatedContourMatrix, numContours] = separateContourMatrix (...
                                                            contourMatrix);
if (bHasImage)
    imagesc (overlayRGB);
end

plotContourMap2D (separatedContourMatrix, numContours);
displayNumberQDs (length (xyCoords));
set (gca, 'fontsize', 15);
saveas (gcf, theInputParser.Results.outputContourPlotFile);
close (gcf);

plot2DProbDensityEst_3D (xCoord, yCoord, pde);
set (gca, 'fontsize', 15);
saveas (gcf, theInputParser.Results.output3DPlotFile);
close (gcf);

probability = getProbability (xCoord, yCoord, pde, ...
                              theInputParser.Results.regionSize);

save (theInputParser.Results.outputPDEDataFile, 'pde', 'xCoord', ...
                                                'yCoord', 'bandwidth', ...
                                                'probability');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      initializeInputParser
%
% Description: Initializes the passed in inputParser object
%
% Parameters:  theInputParser - inputParser object
%
% Returned:    Initialized inputParser object
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [theInputParser] = initializeInputParser (theInputParser)

theInputParser.addRequired ('outputPDEDataFile', @ischar);
theInputParser.addRequired ('outputContourPlotFile', @ischar);
theInputParser.addRequired ('output3DPlotFile', @ischar);
theInputParser.addRequired ('inputData', @(x) ischar (x) || isnumeric (x));
theInputParser.addParamValue ('cellNumber', 1, ...
                              @(x) isscalar (x) && (x > 0));
theInputParser.addParamValue ('imageFile', '', @ischar);
theInputParser.addParamValue ('overlayShift', [0, 0], @(x) isnumeric (x));
theInputParser.addParamValue ('regionSize', REGION_SIZE, ...
                              @(x) isscalar (x));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      getProbability
%
% Description: Returns the probability for the region around the maximum 
%              PDE value
%
% Parameters:  xCoord     - x-coordinate vector
%              yCoord     - y-coordinate vector
%              pde        - the probability density values
%              regionSize - the size of the region that the probability
%                           will be calculated for
%
% Returned:    the probability for the region around the maximum PDE value
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [probability] = getProbability (xCoord, yCoord, pde, regionSize)

binSizes = getBinSize2D (xCoord(1,:), yCoord(:,1));

[col, row] = getMaxPDEIndices (pde);

maxPDERegion = getMaxPDERegion (pde, col, row, regionSize);

probability = calculateProbability (maxPDERegion, binSizes);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      getMaxPDEIndices
%
% Description: Gets the index location of the maximum PDE value in the
%              passed in array of PDE values
%
% Parameters:  pde - the probability density values
%
% Returned:    the index location of the maximum PDE value
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [col, row] = getMaxPDEIndices (pde)

[maxValuesYDirection, yCoordIndices] = max (pde);

[maxValue, col] = max (maxValuesYDirection);

row = yCoordIndices (col);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      getMaxPDERegion
%
% Description: Returns the PDE values for the region centered around the 
%              max PDE value
%
% Parameters:  pde        - the probability density values
%              colMaxPDE  - the column of the max PDE value 
%              rowMaxPDE  - the row of the max PDE value
%              regionSize - the size of the region that the probability
%                           will be calculated for
%
% Returned:    the PDE values for the region around the maximum PDE value
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [maxPDERegion] = getMaxPDERegion (pde, colMaxPDE, rowMaxPDE, ...
                                           regionSize)

maxPDERegion = zeros(regionSize, regionSize);

minColOfRegion = getMinIndexOfRegion (colMaxPDE, regionSize);
minRowOfRegion = getMinIndexOfRegion (rowMaxPDE, regionSize);

regionSizeRowDimension = resizeRegionSize (rowMaxPDE, regionSize, ...
                                           length (pde));
regionSizeColDimension = resizeRegionSize (colMaxPDE, regionSize, ...
                                           length (pde));

for row = 1:regionSizeRowDimension
    for col = 1:regionSizeColDimension
        maxPDERegion(row, col) = pde (rowMaxPDE - minRowOfRegion + ...
                                     (row - 1), colMaxPDE - ...
                                      minColOfRegion + (col - 1));
    end
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      getMinIndexOfRegion
%
% Description: Returns the minimum index value (row or column, depending on
%              what is passed in) of the region of interest around the
%              maximum PDE value
%
% Parameters:  indexOfMaxPDE - location (row or column number) of the
%                              maximum PDE value
%              regionSize    - the size of the region that the probability
%                              will be calculated for
%
% Returned:    the minimum index value (row or column) of the specified
%              region around the max PDE value 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [minIndexOfRegion] = getMinIndexOfRegion (indexOfMaxPDE, ...
                                                   regionSize)
    
    if regionSize / 2 >= indexOfMaxPDE
        minIndexOfRegion = indexOfMaxPDE - 1;
    else 
        minIndexOfRegion = regionSize / 2;
    end
        
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      resizeRegionSize
%
% Description: Resizes the region that the probability will be calculated 
%              over in the event that the sum of regionSize / 2 and the
%              location of the max PDE is greater than the number of PDE
%              values
%
% Parameters:  indexOfMaxPDE - location (row or column number) of the
%                              maximum PDE value
%              regionSize    - the size of the region that the probability
%                              will be calculated for
%              numPDEValues  - the total number of PDE values
%
% Returned:    the new region size that the probability will be calculated
%              over
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [newRegionSize] = resizeRegionSize (indexOfMaxPDE, regionSize, ...
                                             numPDEValues)

    if regionSize / 2 + indexOfMaxPDE > numPDEValues
        newRegionSize = numPDEValues - indexOfMaxPDE + regionSize / 2 + 1;
    else 
        newRegionSize = regionSize;
    end

end
 