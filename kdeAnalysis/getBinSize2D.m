function [binSize2D] = getBinSize2D (pde)

binSize2D (1) = getBinSize (pde (1,:));
binSize2D (2) = getBinSize (pde (:,1));

end

