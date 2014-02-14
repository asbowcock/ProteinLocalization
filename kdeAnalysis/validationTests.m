% norm distribution, 100 data points

dataFile = 'TestCaseResults/Validation/NormalDistribution/normDist,100dp.mat';
contourPlotFile = 'TestCaseResults/Validation/NormalDistribution/normDist,100dp,contour.fig';
plot3DFile = 'TestCaseResults/Validation/NormalDistribution/normDist,100dp,3DPlot.fig';

data = randn (100, 2);
regionSize = 256;
pde2DDriver (dataFile, contourPlotFile, plot3DFile, data,'regionSize', regionSize);

% norm distribution, 1000 data points

dataFile = 'TestCaseResults/Validation/NormalDistribution/normDist,1000dp.mat';
contourPlotFile = 'TestCaseResults/Validation/NormalDistribution/normDist,1000dp,contour.fig';
plot3DFile = 'TestCaseResults/Validation/NormalDistribution/normDist,1000dp,3DPlot.fig';

data = randn (1000, 2);
regionSize = 256;
pde2DDriver (dataFile, contourPlotFile, plot3DFile, data,'regionSize', regionSize);

% uniform distribution, 100 data points

dataFile = 'TestCaseResults/Validation/UniformDistribution/uniformDist,100dp.mat';
contourPlotFile = 'TestCaseResults/Validation/UniformDistribution/uniformDist,100dp,contour.fig';
plot3DFile = 'TestCaseResults/Validation/UniformDistribution/uniformDist,100dp,3DPlot.fig';

data = rand (100, 2);
regionSize = 256;
pde2DDriver (dataFile, contourPlotFile, plot3DFile, data,'regionSize', regionSize);

% uniform distribution, 1000 data points

dataFile = 'TestCaseResults/Validation/UniformDistribution/uniformDist,1000dp.mat';
contourPlotFile = 'TestCaseResults/Validation/UniformDistribution/uniformDist,1000dp,contour.fig';
plot3DFile = 'TestCaseResults/Validation/UniformDistribution/uniformDist,1000dp,3DPlot.fig';

data = rand (1000, 2);
regionSize = 256;
pde2DDriver (dataFile, contourPlotFile, plot3DFile, data,'regionSize', regionSize);

% exponential distribution, 100 data points

dataFile = 'TestCaseResults/Validation/ExponentialDistribution/exponentialDist,100dp.mat';
contourPlotFile = 'TestCaseResults/Validation/ExponentialDistribution/exponentialDist,100dp,contour.fig';
plot3DFile = 'TestCaseResults/Validation/ExponentialDistribution/exponentialDist,100dp,3DPlot.fig';

data = -log (rand (100, 2));
regionSize = 256;
pde2DDriver (dataFile, contourPlotFile, plot3DFile, data,'regionSize', regionSize);

% exponential distribution, 1000 data points

dataFile = 'TestCaseResults/Validation/ExponentialDistribution/exponentialDist,1000dp.mat';
contourPlotFile = 'TestCaseResults/Validation/ExponentialDistribution/exponentialDist,1000dp,contour.fig';
plot3DFile = 'TestCaseResults/Validation/ExponentialDistribution/exponentialDist,1000dp,3DPlot.fig';

data = -log (rand (100, 2));
regionSize = 256;
pde2DDriver (dataFile, contourPlotFile, plot3DFile, data,'regionSize', regionSize);