function [normContourValues] = normalizeContourValues (contourValues)

normContourValues = contourValues;

minContourValue = min (normContourValues);

normContourValues = normContourValues - minContourValue;

maxContourValue = max (normContourValues);

normContourValues = normContourValues ./ maxContourValue;

end