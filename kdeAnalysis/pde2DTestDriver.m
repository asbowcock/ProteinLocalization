matFile = 'C:\Users\Alec\Documents\MATLAB\ProteinLocalization\Exp5_8 cell1 cell2 cell3 cell4 cell5 cell6 cell7.mat';

% no data
vidFile = 'ZeroSecExp2Videos/pde2DDriverTests/noData.avi';
graphFile = 'ZeroSecExp2Videos/pde2DDriverTests/noData.png';

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
vidFile = 'ZeroSecExp2Videos/pde2DDriverTests/invalidCellNum.avi';
graphFile = 'ZeroSecExp2Videos/pde2DDriverTests/invalidCellNum.png';

try 
    pde2DStabilityDriver (vidFile, graphFile, matFile, 'cellNumber', -1);
catch error
    if strcmp ('Argument ''cellNumber'' failed validation @(x)isscalar(x)&&(x>0).', error.message)
        disp ('SUCCESS: Test Case: Invalid cell number');
    else
        disp ('FAILURE: Test Case: Invalid cell number');
    end
end