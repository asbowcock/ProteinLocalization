%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:    checkValidNumOfProbes
%
% Description: Checks the passed in number of probes against the minimum
%              number of probes
%
% Parameters:  numOfProbes - the number of probes
%
% Returned:    True if the number of probes is equal to or greater than the
%              minimum number of probes; false, if otherwise.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [bIsValidNumberOfProbes] = checkValidNumOfProbes (numOfProbes)

bIsValidNumberOfProbes = true;

if (numOfProbes < MIN_NUM_OF_PROBES)
    bIsValidNumberOfProbes = false;
end

end

