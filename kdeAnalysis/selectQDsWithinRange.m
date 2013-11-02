function [selectedQDs] = selectQDsWithinRange(qdDistance, lowerBound, upperBound)

selectedQDs = find (qdDistance > lowerBound & qdDistance < upperBound);

end

