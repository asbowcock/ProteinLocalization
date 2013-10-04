%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      getCellMembraneMIP
%
% Description: Calculates the maximum intensity projection of the cell
%              membrane channel along the z-axis.
%
% Parameters:  controller - the controller class
%              goodSlices - usuable slices of the cell where each slice
%                           exists in the x, y plane
%              cellNumber - the cell that contains the quantum dots
%
% Returned:    The maximum intensity projection of the cell membrane
%              channel along the z-axis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [cellMembraneMIP] = getCellMembraneMIP (controller, goodSlices, cellNumber)

GOOD_SLICE_LOWER_BOUND = 1;
GOOD_SLICE_UPPER_BOUND = 2;
MIP_DIMENSION = 3;

cellMembraneMIP = controller.cellData{cellNumber}.data (:,:,goodSlices{cellNumber}(GOOD_SLICE_LOWER_BOUND):goodSlices{cellNumber}(GOOD_SLICE_UPPER_BOUND));
cellMembraneMIP = max (cellMembraneMIP, [], MIP_DIMENSION);

end

