matFile = 'C:\Users\Alec\Documents\MATLAB\ProteinLocalization\Exp5_8 cell1 cell2 cell3 cell4 cell5 cell6 cell7.mat';

% no data
vidFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/noData.avi';
graphFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/noData.png';

try 
    pde2DStabilityDriver (vidFile, graphFile);
catch error
    if strcmp ('Not enough input arguments.', error.message)
        disp ('SUCCESS: Test Case: No data');
    else
        disp ('FAILURE: Test Case: No data');
    end
end

% pass .mat file with cell number < 1
vidFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/invalidCellNum.avi';
graphFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/invalidCellNum.png';

try 
    pde2DStabilityDriver (vidFile, graphFile, matFile, 'cellNumber', -1);
catch error
    if strcmp ('Argument ''cellNumber'' failed validation @(x)isscalar(x)&&(x>0).', error.message)
        disp ('SUCCESS: Test Case: Invalid cell number');
    else
        disp ('FAILURE: Test Case: Invalid cell number');
    end
end

%{
% pass .mat file and use internal image
vidFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/matFile,InternalIm,ZeroSecExp5_8Cell1.avi';
graphFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/matFile,InternalIm,ZeroSecExp5_8Cell1.png';

pde2DStabilityDriver (vidFile, graphFile, matFile);
disp ('SUCCESS: Test Case: .MAT file w/ internal image');

title ('Zero Sec Exp. 5_8 Cell 1');
close (gcf);

% pass .mat file and use internal image and select cell number
vidFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/matFile,InternalIm,ZeroSecExp5_8Cell2.avi';
graphFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/matFile,InternalIm,ZeroSecExp5_8Cell2.png';

pde2DStabilityDriver (vidFile, graphFile, matFile, 'cellNumber', 2);
disp ('SUCCESS: Test Case: .MAT file w/ internal image & specified cell number');

title ('Zero Sec Exp. 5_8 Cell 2');
close (gcf);

%}
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
%}

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

pde2DStabilityDriver (vidFile, graphFile, data, 'image', imageFile);
disp ('SUCCESS: Test Case: Array w/ image');

clear;
%{
% pass array w/ image and overlay shift
vidFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/array,ExternalIm,Shift,SuperQDExp2_1Cell1.avi';
graphFile = 'ZeroSecExp2Videos/pde2DStabilityDriverTests/array,ExternalIm,Shift,SuperQDExp2_1Cell1.png';

load (matFile);
data = getXYCoords (controller.dataQD{1}{1}.SuperQD);
overlayShift = controller.maskBox{cellNumber}.getPosition;

pde2DStabilityDriver (vidFile, graphFile, data, 'image', imageFile, 'overlayShift', overlayShift);
disp ('SUCCESS: Test Case: Array w/ image and shift');

clear;
%}