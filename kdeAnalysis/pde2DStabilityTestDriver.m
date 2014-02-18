%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:    pde2DStabilityTestDriver
%
% Description: Tests the function pde2DStabilityDriver
%
% Parameters:  None
%
% Returned:    None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

matFile = 'PracticeData/Exp5_8 cell1 cell2 cell3 cell4 cell5 cell6 cell7.mat';

% no data
dataFile = 'TestCaseResults/pde2DStabilityDriverTests/noData.mat';
vidFile = 'TestCaseResults/pde2DStabilityDriverTests/noData.avi';
graphFile = 'TestCaseResults/pde2DStabilityDriverTests/noData';

try 
    pde2DStabilityDriver (dataFile, vidFile, graphFile);
catch error
    if strcmp ('Not enough input arguments.', error.message)
        disp ('SUCCESS: Test Case: No data');
    else
        disp ('FAILURE: Test Case: No data');
    end
end

% pass .mat file with cell number < 1
dataFile = 'TestCaseResults/pde2DStabilityDriverTests/invalidCellNum.mat';
vidFile = 'TestCaseResults/pde2DStabilityDriverTests/invalidCellNum.avi';
graphFile = 'TestCaseResults/pde2DStabilityDriverTests/invalidCellNum';

try 
    pde2DStabilityDriver (dataFile, vidFile, graphFile, matFile, 'cellNumber', -1);
catch error
    if strcmp ('Argument ''cellNumber'' failed validation @(x)isscalar(x)&&(x>0).', error.message)
        disp ('SUCCESS: Test Case: Invalid cell number');
    else
        disp ('FAILURE: Test Case: Invalid cell number');
    end
end

% pass data with invalid number of probes
dataFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/invalidNumProbes';
contourPlotFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/invalidNumProbesContour.fig';
plot3DFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/invalidNumProbes3DPlot.fig';

data = rand (19, 2);

try 
    pde2DDriver (dataFile, contourPlotFile, plot3DFile, data);
catch error
    expectedErrorMsg = strcat ('data set contains less than minimum number of probes: ', {' '}, int2str (MIN_NUM_OF_PROBES));
    
    if strcmp (expectedErrorMsg{1}, error.message)
        disp ('SUCCESS: Test Case: Invalid number of probes');
    else
        disp ('FAILURE: Test Case: Invalid number of probes');
    end
end

% pass data with 20 number of probes
dataFile = 'TestCaseResults/pde2DStabilityDriverTests/numProbes20data';
contourPlotFile = 'TestCaseResults/pde2DStabilityDriverTests/numProbes20Contour.fig';
plot3DFile = 'TestCaseResults/pde2DStabilityDriverTests/numProbes20_3DPlot.fig';
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

%{
% pass .mat file and use internal image
dataFile = 'TestCaseResults/pde2DStabilityDriverTests/matFile,InternalIm,ZeroSecExp5_8Cell1.mat';
vidFile = 'TestCaseResults/pde2DStabilityDriverTests/matFile,InternalIm,ZeroSecExp5_8Cell1.avi';
graphFile = 'TestCaseResults/pde2DStabilityDriverTests/matFile,InternalIm,ZeroSecExp5_8Cell1';

pde2DStabilityDriver (dataFile, vidFile, graphFile, matFile);
disp ('SUCCESS: Test Case: .MAT file w/ internal image');
%}
% pass .mat file and use internal image and select cell number
dataFile = 'TestCaseResults/pde2DStabilityDriverTests/matFile,InternalIm,ZeroSecExp5_8Cell3.mat';
vidFile = 'TestCaseResults/pde2DStabilityDriverTests/matFile,InternalIm,ZeroSecExp5_8Cell3.avi';
graphFile = 'TestCaseResults/pde2DStabilityDriverTests/matFile,InternalIm,ZeroSecExp5_8Cell3';

pde2DStabilityDriver (dataFile, vidFile, graphFile, matFile, 'cellNumber', 3);
disp ('SUCCESS: Test Case: .MAT file w/ internal image & specified cell number');

%{
% pass .mat file and use external image
matFile = 'C:\Users\Alec\Documents\MATLAB\ProteinLocalization\Exp 2 0sec result\Exp2_1 cell1 cell2.mat';
vidFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/matFile,ExternalIm,ZeroSecExp2_1Cell1.avi';
graphFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/matFile,ExternalIm,ZeroSecExp2_1Cell1.png';
imageFile = 'C:\Users\Alec\Documents\MATLAB\ProteinLocalization\ZeroSecExp2Videos\pde2DStabilityDriverTests\zeroSecExp2_1Cell1.tif';

pde2DStabilityDriver (vidFile, graphFile, matFile, 'image', imageFile);
disp ('SUCCESS: Test Case: .MAT file w/ external image');

title ('Zero Sec Exp. 2,1 Cell 1');
close (gcf);

% pass .mat file and use external image with overlay shift
vidFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/matFile,ExternalIm,Shift,SuperQDExp5_1.avi';
graphFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/matFile,ExternalIm,Shift,SuperQDExp5_1.png';

pde2DStabilityDriver (vidFile, graphFile, matFile, 'image', imageFile);
disp ('SUCCESS: Test Case: .MAT file w/ external image and overlay shift');

title ('Super QD Exp. 5_1');
close (gcf);


% pass array w/o image
matFile = 'C:\Users\Alec\Documents\MATLAB\ProteinLocalization\SuperQD\Exp5_1 test.mat';
vidFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/array,ZeroSecExp2_1Cell1.avi';
graphFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/array,ZeroSecExp2_1Cell1.png';

load (matFile);
data = getXYCoords (controller.dataQD{1}{1}.SuperQD);

try
    pde2DStabilityDriver (vidFile, graphFile, data);
catch error
    if strcmp ('Error: when passing array of x,y-coordinates, must pass an image', error.message)
        disp ('SUCCESS: Test Case: Array w/o image');
    else
        disp ('FAILURE: Test Case: Array w/o image');
    end
end

clear;

% pass array w/ image
matFile = 'C:\Users\Alec\Documents\MATLAB\ProteinLocalization\SuperQD\Exp5_1 test.mat';
vidFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/array,ExternalIm,SuperQDExp2_1Cell1.avi';
graphFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/array,ExternalIm,SuperQDExp2_1Cell1.png';
imageFile = 'C:\Users\Alec\Documents\MATLAB\ProteinLocalization\SuperQD\testexp5-1 reference.tif';

load (matFile);
data = getXYCoords (controller.dataQD{1}{1}.SuperQD);

pde2DStabilityDriver (vidFile, graphFile, data, 'imageFile', imageFile);
disp ('SUCCESS: Test Case: Array w/ image');

clear;

% pass array w/ image and overlay shift
vidFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/array,ExternalIm,Shift,SuperQDExp2_1Cell1.avi';
graphFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/array,ExternalIm,Shift,SuperQDExp2_1Cell1.png';

load (matFile);
data = getXYCoords (controller.dataQD{1}{1}.SuperQD);
overlayShift = controller.maskBox{cellNumber}.getPosition;

pde2DStabilityDriver (vidFile, graphFile, data, 'image', imageFile, 'overlayShift', overlayShift);
disp ('SUCCESS: Test Case: Array w/ image and shift');
%}
clear;
