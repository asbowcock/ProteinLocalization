function [probability] = pde2DProbabilityDriver (pde, xCoord, yCoord, contourPlotFile, varargin)

% Initialize input parser
theInputParser = inputParser;
theInputParser = initializeInputParser (theInputParser);
theInputParser.parse (pde, xCoord, yCoord, contourPlotFile, varargin{:});

binSize = getBinSize2D (xCoord(1,:), yCoord(:,1));

hFig = open (contourPlotFile);

dataCursor = datacursormode (hFig);
set (dataCursor,'DisplayStyle','datatip','Enable','on');

disp ('Please select a point on the figure, then press Return');
pause;

dataCursorInfo = getCursorInfo (dataCursor);

xCoordMinIndex = find (pde)

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

theInputParser.addRequired ('pde', @(x) isnumeric (x) && size (x) > 1);
theInputParser.addRequired ('xCoord', @(x) isnumeric (x) && size (x) > 1);
theInputParser.addRequired ('yCoord', @(x) isnumeric (x) && size (x) > 1);
theInputParser.addRequired ('contourPlotFile', @(x) isnumeric (x) && size (x) > 1);
theInputParser.addParamValue ('regionSize', REGION_SIZE, ...
                              @(x) isscalar (x) && 1 == size (x) ...
                              && isa (x, 'integer')) ;
theInputParser.addParamValue ('gridSize', 2^8, ...
                              @(x) isscalar (x) && isa (x, 'integer')) ;                        
end