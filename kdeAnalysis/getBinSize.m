function [binSize] = getBinSize (coordVector)

index = randsample (length (coordVector), 1);

if abs (coordVector (1) - coordVector (2)) ...
    == abs (coordVector (1) - coordVector (index))

    binSize = abs (coordVector (1) - coordVector (2));
    
else
    error ('Error: variable bin size');
end

end

