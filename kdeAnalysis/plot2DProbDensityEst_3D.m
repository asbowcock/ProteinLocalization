%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method:      plot2DProbDensityEst_3D
%
% Description: Plots a three dimensional surface of the two dimensional 
%              probability density estimate.
%
% Parameters:  xCoord      - the x-coordinates of the QDs 
%              yCoord      - the y-coordinates of the QDs
%              probDensity - the two dimensional probability denisity of 
%                            the QDs
%
% Returned:    None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot2DProbDensityEst_3D (xCoord, yCoord, probDensity)

figure;
surf (xCoord, yCoord, probDensity, 'LineStyle', 'none');
axis ij;
xlabel ('x position (pixels)');
ylabel ('y position (pixels)');
zlabel ('Probability Density Estimate (pixels\^{}-2)')
end

