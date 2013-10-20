%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      getSelectedQDsXYZCoords
%
% Description: Returns the x, y, and z coordinates for a select number of 
%              quantums dots.
%
% Parameters:  controller  - the controller class
%              cellNumber  - the cell that contains the quantum dots
%              selectedQDs - the quantum dots of interest
%
% Returned:    The x, y, and z coordinates of the selected quantum dots.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [selectedXYZCoords] = getSelectedQDsXYZCoords (controller, cellNumber, selectedQDs)  

selectedXYZCoords = controller.filteredQD{cellNumber}{1}(selectedQDs,:,:);

end

