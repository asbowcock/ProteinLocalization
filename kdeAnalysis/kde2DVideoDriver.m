%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:    kde2DVideoDriver
% 
% Version:     1.1
%
% Description: Creates a video of the two dimesional probabiliy density 
%              estimate (PDE) of quantum dots in a cell. The video shows 
%              how the 2D PDE, represented as a contour plot, changes as 
%              the number of quantum dots used in calculating the PDE 
%              increases. The contour plot is overlayed on an RGB image of 
%              the cell membrane (green), of the nuclear membrane (green), 
%              and of the QDs(magenta). 
%
% Parameters:  controller - the controller object
%              goodSlices - the good slices of the cell
%              cellNumber - the particular cell containing the QDs
%              fileName   - the video file name
%
% Returned:    None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function kde2DVideoDriver(controller, goodSlices, cellNumber, fileName)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Constants  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FRAME_RATE = 1;
VIDEO_QUALITY = 100;
MIN_NUMBER_OF_QDS = 20;
LOWER_BOUND = -1000000; %nanometers
UPPER_BOUND = 1000000; %nanometers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Initialize the video
theVideo = VideoWriter (fileName);
theVideo.Quality = VIDEO_QUALITY;
theVideo.FrameRate = FRAME_RATE;
open (theVideo);

%Get the QDs to be analyzed
goodQDs = findGoodQDs (controller, cellNumber);
selectQDs = selectQDsWithinRange (controller.distQDtoMembrane{cellNumber}(goodQDs), LOWER_BOUND, UPPER_BOUND);
xyCoords = getXYCoords (getSelectedQDsXYZCoords (controller, cellNumber, goodQDs));

for qdCount = MIN_NUMBER_OF_QDS:length (selectQDs)

%Calculate the probability density estimate
[bandwidth, probDensity, xCoord, yCoord] = kde2d (xyCoords(1:qdCount,:));

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
displayNumberQDs (qdCount);

%capture current frame and write to the video
writeVideo (theVideo, getframe (gcf));
close (gcf);
end

close (theVideo);

end

