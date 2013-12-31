%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:    pde2DStabilityDriver
% 
% Version:     1.2
%
% Description: Creates a video of the two dimesional probabiliy density 
%              estimate (PDE) of probes in a cell. The video shows 
%              how the 2D PDE, represented as a contour plot, changes as 
%              the number of probes used in calculating the PDE 
%              increases. The contour plot is overlayed on an RGB image of 
%              the cell membrane (green), of the nuclear membrane (green), 
%              and of the QDs(magenta). A graph of the change in the PDE
%              with respect to the number of probes is also displayed.
%
% Parameters:  outputVideoFile - file name of the output video 
%              outputGraphFile - file name of change in PDE graph
%              inputData       - either a .mat file containing the 
%                                controller class or a n-by-2 array 
%                                containing x,y-coordinates of the probes
%              cellNumber      - the particular cell containing the probes
%              imageFile       - the file name of the image that the PDE 
%                                will be overlaid on
%              overlayShift    - a 1-by-2 matrix that shifts the
%                                x,y-coordinates of the PDE so the PDE
%                                overlays with the appropriate section of
%                                the image; the first element is the
%                                x-coordinate shift; the second element is
%                                the y-coordinate shift
%
% Returned:    None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function pde2DStabilityDriver (outputVideoFile, outputGraphFile, ...
                               inputData, varargin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Constants  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FRAME_RATE = 1;
VIDEO_QUALITY = 100;
MIN_NUMBER_OF_QDS = 20;
LOWER_BOUND = -1000000; %nanometers
UPPER_BOUND = 1000000; %nanometers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize input parser
theInputParser = inputParser;
theInputParser.addRequired ('outputVideoFile', @ischar);
theInputParser.addRequired ('outputGraphFile', @ischar);
theInputParser.addRequired ('inputData', @(x) ischar (x) || isnumeric (x));
theInputParser.addParamValue ('cellNumber', 1, ...
                              @(x) isscalar (x) && (x > 0));
theInputParser.addParamValue ('image', '', @ischar);
theInputParser.addParamValue ('overlayShift', [0, 0], @(x) isnumeric (x));

% Parse input parameters
theInputParser.parse (outputVideoFile, outputGraphFile, inputData, ...
                      varargin{:});
        
% Initialize the video
theVideo = VideoWriter (theInputParser.Results.outputVideoFile);
theVideo.Quality = VIDEO_QUALITY;
theVideo.FrameRate = FRAME_RATE;
open (theVideo);

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

% Declare array for storing change in PDE
sumPDEDiffSquared = 0;
prevPDE = 0;
pdeChange = zeros (length (xyCoords) - MIN_NUMBER_OF_QDS + 1, 1);
qdNumber = MIN_NUMBER_OF_QDS:length (xyCoords);
qdNumber = qdNumber';

for qdCount = MIN_NUMBER_OF_QDS:length (xyCoords)

% Calculate the probability density estimate
[bandwidth, probDensity, xCoord, yCoord] = kde2d (xyCoords(1:qdCount,:));

%{
% Parse the contour matrix in preparation for plotting the 2D contour plot
contourMatrix = getContourMatrix (xCoord, yCoord, probDensity);
contourMatrix = contourMatrix';
[separatedContourMatrix, numContours] = separateContourMatrix (contourMatrix);

% Display RGB image
imagesc (overlayRGB);

% Plot contour map of 2D PDE over RGB image
plotContourMap2D (separatedContourMatrix, numContours);

% Display number of QDs on 2D contour plot
displayNumberQDs (qdCount);

% Capture current frame and write to the video
writeVideo (theVideo, getframe (gcf));
close (gcf);
%}

% Calculate change in PDE and store value
[pdeChangeTemp, sumPDEDiffSquared] = calculateMSE (probDensity, prevPDE, qdCount, sumPDEDiffSquared);
pdeChange (qdCount - MIN_NUMBER_OF_QDS + 1) = pdeChangeTemp;
prevPDE = probDensity;

end

close (theVideo);

% Plot change in PDE
hFig = figure;
plot (qdNumber, pdeChange);
xlabel ('Number of QDs');
ylabel ('MSE (pixels\^{}-4)');

% Save graph to file
print (hFig, '-dpng', outputGraphFile);

end

