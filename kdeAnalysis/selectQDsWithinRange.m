%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:    selectQDsWithinRange
% 
% Version:     1.0
%
% Description: Selects quantum dots based on a range of distances from a
%              particular point 
%              
%
% Parameters:  qdDistance - distances of the quantum dots
%              lowerBound - the minimum distance of interest
%              upperBound - the maximum distance of interest
%
% Returned:    the selected QDs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [selectedQDs] = selectQDsWithinRange(qdDistance, lowerBound, upperBound)

selectedQDs = find (qdDistance > lowerBound & qdDistance < upperBound);

end

