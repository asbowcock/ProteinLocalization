%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      getBinSize
%
% Description: Gets the bin size (change in coordinate value) for the
%              passed in coordinate vector 
%
% Parameters:  coordVector - a vector of coordinate values 
%          
% Returned:    error if the bin size is not constant; else, the bin size is
%              returned
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [binSize] = getBinSize (coordVector)

%epsilon value for safe comparison because values are floating point
EPSILON = 0.000001; 

index = randsample (numel (coordVector), 1);
diff1 = abs (coordVector(1) - coordVector(2));
diff2 = abs (coordVector(index) - coordVector(index + 1));

if abs (diff1 - diff2) < EPSILON * diff1 
    binSize = diff1;
else
    error ('Error: bin size value is not constant');
end

end

