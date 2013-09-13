%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:    createArtificialData
% Description: Creates pseudo-random 3D data from a normal distribution.
% Parameters:  
%   numDataPoints - number of data points per coordinate
%   bNoise        - true if noise is to be added to data; false if
%                   otherwise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function artificialData = createArtificialData( numDataPoints, bNoise )

NUM_DIMENSIONS = 3;

if bNoise
    artificialData{1} = randn (numDataPoints, NUM_DIMENSIONS); 
else 
    artificialData{1} = randn (numDataPoints, NUM_DIMENSIONS);
end
end

