function [pdeChange] = calculatePDEChange (currentPDE, prevPDE)

pdeChange = sqrt (sum (sum ((currentPDE - prevPDE).^2)));

end

