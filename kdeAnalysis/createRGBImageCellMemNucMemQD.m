%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:    createRGBImageCellMemNucMemQD
% 
% Version:     1.0
%
% Description: Creates an RGB image of the cell membrane (green), of the
%              nuclear membrane (green), and the quantum dots (magenta). 
%
% Parameters:  controller - the controller object
%              goodSlices - the good slices of the cell
%              cellNumber - the particular cell containing the QDs
%
% Returned:    the RGB image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [rgbImage] = createRGBImageCellMemNucMemQD (controller, goodSlices, cellNumber)

cellMembrane = controller.cellData{cellNumber}.data(:,:,floor (median (goodSlices{cellNumber})));
nucMembrane = controller.dataNuc{cellNumber}.data(:,:,floor (median (goodSlices{cellNumber})));
qdMIP = getQDMaxIntensityProjection (controller, goodSlices, cellNumber);

rgbImage = zeros (size (qdMIP, 1), size (qdMIP, 2), NUM_OF_DIMENSIONS);
rgbImage (:,:,RED_CHANNEL) = imadjust (mat2gray (qdMIP));
rgbImage (:,:,BLUE_CHANNEL) = imadjust (mat2gray (qdMIP));
rgbImage (:,:,GREEN_CHANNEL) = imadjust (mat2gray (cellMembrane) + mat2gray (nucMembrane),[], [], GAMMA);

end

