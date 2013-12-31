function [mise] = calculateMISE (currentPDE, prevPDE, xBinSize, yBinSize)

mise = mean (mean (currentPDE)) * trapz (trapz ((currentPDE - prevPDE).^2)) ...
       * xBinSize * yBinSize;

end

