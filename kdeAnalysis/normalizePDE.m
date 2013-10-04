%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      normProbDensity
%
% Description: Normalizes the passed-in two dimensional probability density
%              estimate.
%
% Parameters:  probDensity - the two dimensional probability denisity of 
%                            the QDs
%
% Returned:    The normalized two dimensional probability density estimate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [normProbDensity] = normalizePDE (probDensity)

maxValue = max (probDensity);
maxValue = max (maxValue);

normProbDensity = probDensity ./ maxValue;

end

