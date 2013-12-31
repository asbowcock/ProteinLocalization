%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      calculateProbability
%
% Description: Calculates the probability for the passed in PDE
%
% Parameters:  probability - the x-coordinates of the QDs 
%              binSize     - a vector containing the bin size for the
%              x-direction (stored as the first element) and for the
%              y-direction (stored as the second element)
%          
% Returned:    the probability
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [probability] = calculateProbability (pde, binSize)

probability = trapz (trapz (pde)) * binSize (1) * binSize (2);

end

