function [rgbImage] = createRGBImageCellMemNucMemQD (controller, goodSlices, cellNumber)

cellMembrane = controller.cellData{cellNumber}.data(:,:,floor (median (goodSlices{cellNumber})));
nucMembrane = controller.dataNuc{cellNumber}.data(:,:,floor (median (goodSlices{cellNumber})));
qdMIP = getQDMaxIntensityProjection (controller, goodSlices, cellNumber);

rgbImage = zeros (size (qdMIP, 1), size (qdMIP, 2), NUM_OF_DIMENSIONS);
rgbImage (:,:,RED_CHANNEL) = imadjust (mat2gray (qdMIP));
rgbImage (:,:,BLUE_CHANNEL) = imadjust (mat2gray (qdMIP));
rgbImage (:,:,GREEN_CHANNEL) = imadjust (mat2gray (cellMembrane) + mat2gray (nucMembrane),[], [], GAMMA);

end

