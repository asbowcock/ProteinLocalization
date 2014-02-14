% norm distribution, 100 data points

dataFile = 'TestCaseResults/Validation/NormalDistribution/normDist,100dp.mat';
contourPlotFile = 'TestCaseResults/Validation/NormalDistribution/normDist,100dp,contour.fig';
plot3DFile = 'TestCaseResults/Validation/NormalDistribution/normDist,100dp,3DPlot.fig';
%imageFile = 'TestCaseResults/Validation/emptyImage.png';

data = randn (100, 2);
regionSize = 256;
pde2DDriver (dataFile, contourPlotFile, plot3DFile, data,'regionSize', regionSize);