function [rmse, sumPDEDiffSquared] = calculateRMSE (currentPDE, prevPDE, qdCount, sumPDEDiffSquared)

sumPDEDiffSquared = sumPDEDiffSquared + sqrt (sum (sum ((currentPDE - prevPDE).^2))); 

rmse = 1 / qdCount * sumPDEDiffSquared;

end


