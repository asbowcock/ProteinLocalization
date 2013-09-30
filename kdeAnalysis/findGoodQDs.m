%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      findGoodQDs
%
% Description: Finds and returns the "good" quantum dots stored in the 
%              Controller class. "Good" refers to quantum dots that have
%              been identified as usuable quantum dots.
%
% Parameters:  controller - the controller class
%              cellNumber - the cell that contains the quantum dots
%
% Returned:    The quantum dots that have been classified as "good"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [goodQDs] = findGoodQDs(controller, cellNumber)

goodQDs = find (controller.goodPoints{cellNumber} == 1);

end

