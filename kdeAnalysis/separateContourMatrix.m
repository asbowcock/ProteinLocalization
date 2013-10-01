%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      separateContourMatrix
%
% Description: Separates the passed in contour matrix into a matrix
%              containing the contour value, the number of x,y coordinates
%              for that contour value, and a matrix with the associated x,y
%              coordinates.
%
% Parameters:  contourMatrix - a contour matrix from the contour () method
%
% Returned:    The separated contour matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [separatedContourMatrix, numContours] = separateContourMatrix (contourMatrix)

%Constants
X_COORD = 1;
Y_COORD = 2;
CONTOUR_VALUE_LOCATION = 1;
NUM_XY_COORDS_LOCATION = 2;
XY_COORDS_LOCATION = 3;

%Variables
indexContourMatrix = 1;
numContours = 0;
separatedContourMatrix = cell (1, 3); %initializes cell array; will grow if need be
indexXYCoords = 0; %counter used for number of x,y coordinates entered into separatedContourMatrix for particular contour number

while indexContourMatrix <= length (contourMatrix)
   numContours = numContours + 1;
   
   %Place contour value in separated contour matrix
   separatedContourMatrix{numContours, CONTOUR_VALUE_LOCATION} = contourMatrix (indexContourMatrix, CONTOUR_VALUE_LOCATION);
   
   %Place number of x,y-coordinates for particular contour value in
   %separated contour matrix
   numXYCoordsForContourValue = contourMatrix (indexContourMatrix, NUM_XY_COORDS_LOCATION);
   separatedContourMatrix{numContours, NUM_XY_COORDS_LOCATION} = numXYCoordsForContourValue;
   
   indexContourMatrix = indexContourMatrix + 1;
   indexXYCoords = 0; 
   
   %Place each x- and y-coordinate for the particular contour value in the
   %separated contour matrix
   for i = indexContourMatrix:indexContourMatrix + numXYCoordsForContourValue - 1
      indexXYCoords = indexXYCoords + 1;
       
      separatedContourMatrix{numContours, XY_COORDS_LOCATION} (indexXYCoords, X_COORD) = contourMatrix (i, X_COORD);
      separatedContourMatrix{numContours, XY_COORDS_LOCATION} (indexXYCoords, Y_COORD) = contourMatrix (i, Y_COORD);  
   end
   
   %Advance index for contour matrix to next contour value location in
   %contourMatrix
   indexContourMatrix = indexContourMatrix + numXYCoordsForContourValue;
   
end

end

