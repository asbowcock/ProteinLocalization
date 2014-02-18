%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      ERROR_MSG_INVALID_NUM_OF_PROBES
%
% Description: Defines the error message for when an invalid number of 
%              probes are used
%
% Parameters:  None
%
% Returned:    The error message for when an invalid number of probes 
%              are used
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [errorMsgInvalidNumOfProbes] = ERROR_MSG_INVALID_NUM_OF_PROBES ()

errorMsgInvalidNumOfProbes = strcat ('data set contains less than minimum number of probes: ', {' '}, int2str (MIN_NUM_OF_PROBES));

end

