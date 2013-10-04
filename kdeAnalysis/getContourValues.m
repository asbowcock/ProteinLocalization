function [contourValues] = getContourValues (parsedContourMatrix, numContours)

CONTOUR_VALUE_LOCATION = 1;
contourValues = zeros (numContours, 1);

for i = 1:numContours
   
    contourValues(i) = parsedContourMatrix{i, CONTOUR_VALUE_LOCATION};
    
end

end

