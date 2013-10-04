%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      normalizeContourValues
%
% Description: Normalizes the passed-in contour values to values between 0
%              and 1, inclusive.
%
% Parameters:  contourValues      - values for each contour line
%
% Returned:    The normalized contour values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [normContourValues] = normalizeContourValues (contourValues)

normContourValues = contourValues;

minContourValue = min (normContourValues);

normContourValues = normContourValues - minContourValue;

maxContourValue = max (normContourValues);

normContourValues = normContourValues ./ maxContourValue;

end