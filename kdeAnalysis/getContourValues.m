%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      getUniqueContourValues
%
% Description: Gets the contour values from the parsed contour matrix.
%
% Parameters:  parsedContourMatrix - the separated contour matrix
%                                    containing the contour values, their
%                                    corresponding number of x,
%                                    y-coordinates, and the x,
%                                    y-coordinates
%              numContourValues    - the number of contour values
%
% Returned:    The contour values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [contourValues] = getContourValues (parsedContourMatrix, numContours)

CONTOUR_VALUE_LOCATION = 1;
contourValues = zeros (numContours, 1);

for i = 1:numContours
   
    contourValues(i) = parsedContourMatrix{i, CONTOUR_VALUE_LOCATION};
    
end

end
