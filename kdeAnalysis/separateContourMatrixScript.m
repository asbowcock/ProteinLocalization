
X_COORD = 1;
Y_COORD = 2;
CONTOUR_VALUE_LOCATION = 1;
NUM_XY_COORDS_LOCATION = 2;
XY_COORDS_LOCATION = 3;

%{
indexContourMatrix = 1;
numContours = 0;
separatedContourMatrix = cell (1, 3); %initializes cell array; will grow if need be
indexXYCoords = 0; %counter used for number of x,y coordinates entered into separatedContourMatrix for particular contour number

while indexContourMatrix <= length (contourMatrix)
   numContours = numContours + 1;
   
   %Place contour value in separated contour matrix
   separatedContourMatrix{numContours, CONTOUR_VALUE_LOCATION} = contourMatrix (indexContourMatrix, CONTOUR_VALUE_LOCATION);
   
   %Place number of x,y-coordinates for particular contour value in
   %separated contour matrix
   numXYCoordsForContourValue = contourMatrix (indexContourMatrix, NUM_XY_COORDS_LOCATION);
   separatedContourMatrix{numContours, NUM_XY_COORDS_LOCATION} = numXYCoordsForContourValue;
   
   indexContourMatrix = indexContourMatrix + 1;
   indexXYCoords = 0; 
   
   %Place each x- and y-coordinate for the particular contour value in the
   %separated contour matrix
   for i = indexContourMatrix:indexContourMatrix + numXYCoordsForContourValue - 1
      indexXYCoords = indexXYCoords + 1;
       
      separatedContourMatrix{numContours, XY_COORDS_LOCATION} (indexXYCoords, X_COORD) = contourMatrix (i, X_COORD);
      separatedContourMatrix{numContours, XY_COORDS_LOCATION} (indexXYCoords, Y_COORD) = contourMatrix (i, Y_COORD);  
   end
   
   %Advance index for contour matrix to next contour value location in
   %contourMatrix
   indexContourMatrix = indexContourMatrix + numXYCoordsForContourValue;
   
end
%}
hold on 
for i = 1:numContours
    hPlot = plot (separatedContourMatrix{i, XY_COORDS_LOCATION}(:, X_COORD), separatedContourMatrix{i, XY_COORDS_LOCATION}(:, Y_COORD)); 
    
    %bootstrap: if statements because cases won't
    %initiate in switch statement
    
    if separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} > 0 && separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} < 0.00002
        set (hPlot, 'Color', 'blue');
    end
    
    if separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} > 0.00001 && separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} < 0.00003
        set (hPlot, 'Color', 'cyan');
    end
    
    if separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} > 0.00002 && separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} < 0.00004
        set (hPlot, 'Color', 'green');
    end
    
    if separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} > 0.00003 && separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} < 0.00005
        set (hPlot, 'Color', 'yellow');
    end
    
    if separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} > 0.00004 && separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} < 0.00006
        set (hPlot, 'Color', [0.75, 0.1608, 0]);
    end
    
    if separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} > 0.00005 && separatedContourMatrix{i, CONTOUR_VALUE_LOCATION} < 0.00007
        set (hPlot, 'Color', 'red');
    end
    
end

        
      