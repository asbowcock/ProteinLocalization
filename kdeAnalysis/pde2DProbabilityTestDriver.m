
load ('C:\Users\Alec\Documents\MATLAB\ProteinLocalization\ZeroSecExp2Videos\pde2DDriverTests\matFile,InternalIm,ZeroSecExp5_8Cell1.mat');

% getBinSize2D test

binSize = getBinSize2D (xCoord(1,:), yCoord(:,1)');

if 0 ~= binSize(1) && 0 ~= binSize(2)
    disp ('SUCCESS: Test Case: getBinSize2D');
else
    disp ('FAILURE: Test Case: getBinSize2D');
end

