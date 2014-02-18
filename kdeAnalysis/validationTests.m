%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:    validationTests
%
% Description: Performs the validation tests for the 2D PDE algorithm
%
% Parameters:  None
%
% Returned:    None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% norm distribution, 10000 data points

dataFile = 'TestCaseResults/Validation/NormalDistribution/normDist,10000dp.mat';
contourPlotFile = 'TestCaseResults/Validation/NormalDistribution/normDist,10000dp,contour';
plot3DFile = 'TestCaseResults/Validation/NormalDistribution/normDist,10000dp,3DPlot';

data = randn (10000, 2);
regionSize = 256;
pde2DDriver (dataFile, contourPlotFile, plot3DFile, data,'regionSize', regionSize);

hFig = hgload (contourPlotFile);
axis tight;
axisLimitsContour = axis;
saveas (hFig, contourPlotFile);
print (hFig, '-dpng', contourPlotFile);
close gcf;

hFig = hgload (plot3DFile);
axis tight;
axisLimitsSurf = axis;
saveas (hFig, plot3DFile);
print (hFig, '-dpng', plot3DFile);
close gcf;

% norm distribution, 1000 data points

dataFile = 'TestCaseResults/Validation/NormalDistribution/normDist,1000dp.mat';
contourPlotFile = 'TestCaseResults/Validation/NormalDistribution/normDist,1000dp,contour';
plot3DFile = 'TestCaseResults/Validation/NormalDistribution/normDist,1000dp,3DPlot';

data = randn (1000, 2);
regionSize = 256;
pde2DDriver (dataFile, contourPlotFile, plot3DFile, data,'regionSize', regionSize);

% norm distribution, 100 data points

dataFile = 'TestCaseResults/Validation/NormalDistribution/normDist,100dp.mat';
contourPlotFile = 'TestCaseResults/Validation/NormalDistribution/normDist,100dp,contour';
plot3DFile = 'TestCaseResults/Validation/NormalDistribution/normDist,100dp,3DPlot';

data = randn (100, 2);
regionSize = 256;
pde2DDriver (dataFile, contourPlotFile, plot3DFile, data,'regionSize', regionSize);

hFig = hgload (contourPlotFile);
axis (axisLimitsContour);
saveas (hFig, contourPlotFile);
print (hFig, '-dpng', contourPlotFile);
close gcf;

hFig = hgload (plot3DFile);
axis (axisLimitsSurf);
saveas (hFig, plot3DFile);
print (hFig, '-dpng', plot3DFile);
close gcf;

% uniform distribution, 10000 data points

dataFile = 'TestCaseResults/Validation/UniformDistribution/uniformDist,10000dp.mat';
contourPlotFile = 'TestCaseResults/Validation/UniformDistribution/uniformDist,10000dp,contour';
plot3DFile = 'TestCaseResults/Validation/UniformDistribution/uniformDist,10000dp,3DPlot';

data = rand (10000, 2);
regionSize = 256;
pde2DDriver (dataFile, contourPlotFile, plot3DFile, data,'regionSize', regionSize);

hFig = hgload (contourPlotFile);
axis tight;
axisLimitsContour = axis;
saveas (hFig, contourPlotFile);
print (hFig, '-dpng', contourPlotFile);
close gcf;

hFig = hgload (plot3DFile);
axis tight;
axisLimitsSurf = axis;
saveas (hFig, plot3DFile);
print (hFig, '-dpng', plot3DFile);
close gcf;

% uniform distribution, 1000 data points

dataFile = 'TestCaseResults/Validation/UniformDistribution/uniformDist,1000dp.mat';
contourPlotFile = 'TestCaseResults/Validation/UniformDistribution/uniformDist,1000dp,contour';
plot3DFile = 'TestCaseResults/Validation/UniformDistribution/uniformDist,1000dp,3DPlot';

data = rand (1000, 2);
regionSize = 256;
pde2DDriver (dataFile, contourPlotFile, plot3DFile, data,'regionSize', regionSize);

% uniform distribution, 100 data points

dataFile = 'TestCaseResults/Validation/UniformDistribution/uniformDist,100dp.mat';
contourPlotFile = 'TestCaseResults/Validation/UniformDistribution/uniformDist,100dp,contour';
plot3DFile = 'TestCaseResults/Validation/UniformDistribution/uniformDist,100dp,3DPlot';

data = rand (100, 2);
regionSize = 256;
pde2DDriver (dataFile, contourPlotFile, plot3DFile, data,'regionSize', regionSize);

hFig = hgload (contourPlotFile);
axis (axisLimitsContour);
saveas (hFig, contourPlotFile);
print (hFig, '-dpng', contourPlotFile);
close gcf;

hFig = hgload (plot3DFile);
axis (axisLimitsSurf);
saveas (hFig, plot3DFile);
print (hFig, '-dpng', plot3DFile);
close gcf;

% exponential distribution, 10000 data points

dataFile = 'TestCaseResults/Validation/ExponentialDistribution/exponentialDist,10000dp.mat';
contourPlotFile = 'TestCaseResults/Validation/ExponentialDistribution/exponentialDist,10000dp,contour';
plot3DFile = 'TestCaseResults/Validation/ExponentialDistribution/exponentialDist,10000dp,3DPlot';

data = -log (rand (10000, 2));
regionSize = 256;
pde2DDriver (dataFile, contourPlotFile, plot3DFile, data,'regionSize', regionSize);

hFig = hgload (contourPlotFile);
axis tight;
axisLimitsContour = axis;
saveas (hFig, contourPlotFile);
print (hFig, '-dpng', contourPlotFile);
close gcf;

hFig = hgload (plot3DFile);
axis tight;
axisLimitsSurf = axis;
saveas (hFig, plot3DFile);
print (hFig, '-dpng', plot3DFile);
close gcf;

% exponential distribution, 1000 data points

dataFile = 'TestCaseResults/Validation/ExponentialDistribution/exponentialDist,1000dp.mat';
contourPlotFile = 'TestCaseResults/Validation/ExponentialDistribution/exponentialDist,1000dp,contour';
plot3DFile = 'TestCaseResults/Validation/ExponentialDistribution/exponentialDist,1000dp,3DPlot';

data = -log (rand (1000, 2));
regionSize = 256;
pde2DDriver (dataFile, contourPlotFile, plot3DFile, data,'regionSize', regionSize);

% exponential distribution, 100 data points

dataFile = 'TestCaseResults/Validation/ExponentialDistribution/exponentialDist,100dp.mat';
contourPlotFile = 'TestCaseResults/Validation/ExponentialDistribution/exponentialDist,100dp,contour';
plot3DFile = 'TestCaseResults/Validation/ExponentialDistribution/exponentialDist,100dp,3DPlot';

data = -log (rand (100, 2));
regionSize = 256;
pde2DDriver (dataFile, contourPlotFile, plot3DFile, data,'regionSize', regionSize);

hFig = hgload (contourPlotFile);
axis (axisLimitsContour);
saveas (hFig, contourPlotFile);
print (hFig, '-dpng', contourPlotFile);
close gcf;

hFig = hgload (plot3DFile);
axis (axisLimitsSurf);
saveas (hFig, plot3DFile);
print (hFig, '-dpng', plot3DFile);
close gcf;

clear;