%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:    pde2DDriver
% 
% Version:     1.21
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

% If .mat file has been passed in
if (ischar (theInputParser.Results.inputData))
    
    load (theInputParser.Results.inputData);

    goodQDs = findGoodQDs (controller, theInputParser.Results.cellNumber);
    selectQDs = selectQDsWithinRange (controller.distQDtoMembrane{theInputParser.Results.cellNumber}(goodQDs), LOWER_BOUND, UPPER_BOUND);
    xyCoords = getXYCoords (getSelectedQDsXYZCoords (controller, ...
                            theInputParser.Results.cellNumber, selectQDs));
    
    % No image file passed in, so use image in controller class
    if (strcmp (theInputParser.Results.image, ''))
        overlayRGB = createRGBImageCellMemNucMemQD (controller, ...
                                                    goodSlices, ...
                                        theInputParser.Results.cellNumber);
    else
        overlayRGB = imread (theInputParser.Results.image);
    end
% If array of x,y-coordinates has been passed in    
else
    xyCoords = theInputParser.Results.inputData;
    
    if (strcmp (theInputParser.Results.image, ''))
        error ('Error: when passing array of x,y-coordinates, must pass an image');
    else
        overlayRGB = imread (theInputParser.Results.image);
    end
end

% Calculate the probability density estimate
[bandwidth, pde, xCoord, yCoord] = kde2d (xyCoords);

xCoord = xCoord + theInputParser.Results.overlayShift(1);
yCoord = yCoord + theInputParser.Results.overlayShift(2); 

% Parse the contour matrix in preparation for plotting the 2D contour plot
contourMatrix = getContourMatrix (xCoord, yCoord, pde);
contourMatrix = contourMatrix';
[separatedContourMatrix, numContours] = separateContourMatrix (contourMatrix);

imagesc (overlayRGB);

plotContourMap2D (separatedContourMatrix, numContours);
displayNumberQDs (length (xyCoords));
saveas (gcf, theInputParser.Results.outputContourPlotFile);
close (gcf);

plot2DProbDensityEst_3D (xCoord, yCoord, pde);
saveas (gcf, theInputParser.Results.output3DPlotFile);
close (gcf);

save (theInputParser.Results.outputPDEDataFile, 'pde', 'xCoord', ...
                                                'yCoord', 'bandwidth');

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
theInputParser.addParamValue ('image', '', @ischar);
theInputParser.addParamValue ('overlayShift', [0, 0], @(x) isnumeric (x));
theInputParser.addParamValue ('regionSize', REGION_SIZE, ...
                              @(x) isscalar (x) && isa (x, 'integer'));
end
