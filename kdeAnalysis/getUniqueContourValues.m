%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      getUniqueContourValues
%
% Description: Finds unique contour values from an array of contour values.
%
% Parameters:  contourValues      - values for each contour line
%              numContourValues   - the number of contour values
%
% Returned:    The unique contour values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [uniqueContourValues] = getUniqueContourValues(contourValues, numContourValues)

numUniqueContourValues = 0;

if numContourValues > 0
    numUniqueContourValues = numUniqueContourValues + 1;
    
    uniqueContourValues(numUniqueContourValues) = contourValues(1);
    
    for i = 2:numContourValues
        if (contourValues(i) ~= uniqueContourValues(numUniqueContourValues))
            numUniqueContourValues = numUniqueContourValues + 1;
            uniqueContourValues(numUniqueContourValues) = contourValues(i);
        end
    end
end

end

