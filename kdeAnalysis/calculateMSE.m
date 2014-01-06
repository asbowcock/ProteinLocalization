%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      calculateMSE
%
% Description: Calculates the Mean Squared Error for the passed in 
%
% Parameters:  currentPDE        - the x-coordinates of the QDs 
%              prevPDE           - the y-coordinates of the QDs
%              probeCount        - the two dimensional probability denisity 
%                                  of the probes
%              sumPDEDiffSquared - the sum from the minimum number of 
%                                  probes to n - 1 probes of the square of 
%                                  the difference in PDEs
%
% Returned:    the Mean Square Error and the sum from minimum number of 
%              probes to n probes of the square of the difference in PDEs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [mse, sumPDEDiffSquared] = calculateMSE (currentPDE, prevPDE, ...
                                                  probeCount, ...
                                                  sumPDEDiffSquared)

sumPDEDiffSquared = sumPDEDiffSquared ...
                    + sum (sum ((currentPDE - prevPDE).^2)); 

mse = 1 / probeCount * sumPDEDiffSquared;

end

