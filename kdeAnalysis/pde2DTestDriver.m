%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:    pde2DTestDriver
%
% Description: Tests the function pde2DDriver
%
% Parameters:  None
%
% Returned:    None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

matFile = 'PracticeData/Exp5_8 cell1 cell2 cell3 cell4 cell5 cell6 cell7.mat';

% no data
dataFile = 'TestCaseResults/pde2DDriverTests/noData';
contourPlotFile = 'TestCaseResults/pde2DDriverTests/noData.fig';
plot3DFile = 'TestCaseResults/pde2DDriverTests/invalidCellNum3DPlot.fig';

try 
    pde2DDriver (dataFile, contourPlotFile, plot3DFile);
catch error
    if strcmp ('Not enough input arguments.', error.message)
        disp ('SUCCESS: Test Case: No data');
    else
        disp ('FAILURE: Test Case: No data');
    end
end

% pass .mat file with cell number < 1
dataFile = 'TestCaseResults/pde2DDriverTests/invalidCellNum';
contourPlotFile = 'TestCaseResults/pde2DDriverTests/invalidCellNumContour.fig';
plot3DFile = 'TestCaseResults/pde2DDriverTests/invalidCellNum3DPlot.fig';

try 
    pde2DDriver (dataFile, contourPlotFile, plot3DFile, matFile, 'cellNumber', -1);
catch error
    if strcmp ('Argument ''cellNumber'' failed validation @(x)isscalar(x)&&(x>0).', error.message)
        disp ('SUCCESS: Test Case: Invalid cell number');
    else
        disp ('FAILURE: Test Case: Invalid cell number');
    end
end

% pass data with invalid number of probes
dataFile = 'TestCaseResults/pde2DDriverTests/invalidNumProbes';
contourPlotFile = 'TestCaseResults/pde2DDriverTests/invalidNumProbesContour.fig';
plot3DFile = 'TestCaseResults/pde2DDriverTests/invalidNumProbes3DPlot.fig';

data = rand (19, 2);

try 
    pde2DDriver (dataFile, contourPlotFile, plot3DFile, data);
catch error
    expectedErrorMsgInvalidNumOfProbes = ERROR_MSG_INVALID_NUM_OF_PROBES;
    
    if strcmp (expectedErrorMsgInvalidNumOfProbes{1}, error.message)
        disp ('SUCCESS: Test Case: Invalid number of probes');
    else
        disp ('FAILURE: Test Case: Invalid number of probes');
    end
end

% pass data with 20 number of probes
dataFile = 'TestCaseResults/pde2DDriverTests/numProbes20data';
contourPlotFile = 'TestCaseResults/pde2DDriverTests/numProbes20Contour.fig';
plot3DFile = 'TestCaseResults/pde2DDriverTests/numProbes20_3DPlot.fig';
bIsError = false;

data = rand (20, 2);

try 
    pde2DDriver (dataFile, contourPlotFile, plot3DFile, data);
catch error
    expectedErrorMsgInvalidNumOfProbes = ERROR_MSG_INVALID_NUM_OF_PROBES;
    
    if strcmp (expectedErrorMsgInvalidNumOfProbes, error.message)
        disp ('FAILURE: Test Case: 20 probes');
        bIsError = true;
    end
end

if (~bIsError)
    disp ('SUCCESS: Test Case: 20 probes');
end

% pass .mat file and use internal image
dataFile = 'TestCaseResults/pde2DDriverTests/matFile,InternalIm,ZeroSecExp5_8Cell1.mat';
contourPlotFile = 'TestCaseResults/pde2DDriverTests/matFile,InternalIm,ZeroSecExp5_8Cell1Contour.fig';
plot3DFile = 'TestCaseResults/pde2DDriverTests/matFile,InternalIm,ZeroSecExp5_8Cell13DPlot.fig';

pde2DDriver (dataFile, contourPlotFile, plot3DFile, matFile);
disp ('SUCCESS: Test Case: .MAT file w/ internal image');

% pass .mat file and use internal image and select cell number
dataFile = 'TestCaseResults/pde2DDriverTests/matFile,InternalIm,ZeroSecExp5_8Cell2';
contourPlotFile = 'TestCaseResults/pde2DDriverTests/matFile,InternalIm,ZeroSecExp5_8Cell2,Contour.fig';
plot3DFile = 'TestCaseResults/pde2DDriverTests/matFile,InternalIm,ZeroSecExp5_8Cell2,3DPlot.fig';

pde2DDriver (dataFile, contourPlotFile, plot3DFile, matFile, 'cellNumber', 2);
disp ('SUCCESS: Test Case: .MAT file w/ internal image & specified cell number');

%{
% pass .mat file and use external image
dataFile = 'ZeroSecExp2Videos/pde2DDriverTests/matFile,ExternalIm,ZeroSecExp5_8Cell1';
contourPlotFile = 'ZeroSecExp2Videos/pde2DDriverTests/matFile,ExternalIm,ZeroSecExp5_8Cell1,Contour.fig';
plot3DFile = 'ZeroSecExp2Videos/pde2DDriverTests/matFile,ExternalIm,ZeroSecExp5_8Cell1,3DPlot.fig';
imageFile = 'C:\Users\Alec\Documents\MATLAB\ProteinLocalization\ZeroSecExp2Videos\pde2DDriverTests\zeroSecExp5_8Cell1,RGBImage.tif';

pde2DDriver (dataFile, contourPlotFile, plot3DFile, matFile, 'image', imageFile);
disp ('SUCCESS: Test Case: .MAT file w/ external image');
%}
% pass .mat file and external image with shift

% pass array w/o image
matFile = 'SuperQD\Exp5_1 test.mat';
dataFile = 'TestCaseResults/pde2DDriverTests/array,SuperQDExp5_1';
contourPlotFile = 'TestCaseResults/pde2DDriverTests/array,SuperQDExp5_1,ContourPlot.fig';
plot3DFile = 'TestCaseResults/pde2DDriverTests/array,SuperQDExp5_1,3DPlot.fig';

load (matFile);
data = getXYCoords (controller.dataQD{1}{1}.SuperQD);

pde2DDriver (dataFile, contourPlotFile, plot3DFile, data);
disp ('SUCCESS: Test Case: Array w/o image');

%{
try
    pde2DDriver (dataFile, contourPlotFile, plot3DFile, data);
catch error
    if strcmp ('Error: when passing array of x,y-coordinates, must pass an image', error.message)
        disp ('SUCCESS: Test Case: Array w/o image');
    else
        disp ('FAILURE: Test Case: Array w/o image');
    end
end
%}

% pass array w/ image
matFile = 'SuperQD\Exp5_1 test.mat';
dataFile = 'TestCaseResults/pde2DDriverTests/array,ExternalIm,Shift,SuperQDExp5_1.mat';
contourPlotFile = 'TestCaseResults/pde2DDriverTests/array,ExternalIm,SuperQDExp5_1Cell1,Contour.fig';
plot3DFile = 'TestCaseResults/pde2DDriverTests/array,ExternalIm,SuperQDExp5_1Cell1,Plot3D.fig';
imageFile = 'SuperQD\testexp5-1 reference.tif';

load (matFile);
data = getXYCoords (controller.dataQD{1}{1}.SuperQD);

pde2DDriver (dataFile, contourPlotFile, plot3DFile, data, 'imageFile', imageFile);
disp ('SUCCESS: Test Case: Array w/ image');

% pass array w/ image and shift
matFile = 'SuperQD\Exp5_1 test.mat';
dataFile = 'TestCaseResults/pde2DDriverTests/array,ExternalIm,Shift,SuperQDExp5_1.mat';
contourPlotFile = 'TestCaseResults/pde2DDriverTests/array,ExternalIm,Shift,SuperQDExp5_1Cell1,Contour.fig';
plot3DFile = 'TestCaseResults/pde2DDriverTests/array,ExternalIm,Shift,SuperQDExp5_1Cell1,Plot3D.fig';
imageFile = 'SuperQD\testexp5-1 reference.tif';

load (matFile);
data = getXYCoords (controller.dataQD{1}{1}.SuperQD);
overlayShift = controller.maskBox{1}.getPosition;

pde2DDriver (dataFile, contourPlotFile, plot3DFile, data, 'imageFile', imageFile, 'overlayShift', overlayShift);
disp ('SUCCESS: Test Case: Array w/ image and shift');

% pass data from normally distributed pseudorandom generator and integrate 
% over entire array of PDE values; should acquire approximately 1

dataFile = 'TestCaseResults/pde2DDriverTests/probabilityTest,10dp,10by10.mat';
contourPlotFile = 'TestCaseResults/pde2DDriverTests/probabilityTestContour,10dp,10by10.fig';
plot3DFile = 'TestCaseResults/pde2DDriverTests/probabilityTest3D,10dp,10by10.fig';

data = randn (20, 2);
regionSize = 256;
pde2DDriver (dataFile, contourPlotFile, plot3DFile, data, 'regionSize', regionSize);
disp ('SUCCESS: Test Case: Probability');

clear;