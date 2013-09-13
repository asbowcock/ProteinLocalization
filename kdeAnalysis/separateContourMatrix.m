indexContourMatrix = 1;
numContours = 0;
%zLevel = zeros(length (contourMatrix), 1);
%xCoordContour = zeros(length (contourMatrix), 2);
%yCoordContour = zeros(length (contourMatrix), 2);
contourCellArray = cell (17, 3);

while indexContourMatrix <= length (contourMatrix)
   numContours  = numContours + 1;
   
   numZLevelPairs = contourMatrix(indexContourMatrix, 2);
   contourCellArray{numContours, 1} = numZLevelPairs;
   
   %zLevel(contourNumber) = contourMatrix(index, 1);
   contourCellArray{numContours, 3} = contourMatrix(indexContourMatrix, 1);
   
   indexContourMatrix = indexContourMatrix + 1;
   xyCoordIndex = 1;
   
   for i = indexContourMatrix:indexContourMatrix + numZLevelPairs - 1
      %xCoordContour(contourNumber, i) = contourMatrix(i, 1);
      %yCoordContour(contourNumber, i) = contourMatrix(i, 2);
      
      contourCellArray{numContours, 2}(xyCoordIndex, 1) = contourMatrix(i, 1);
      contourCellArray{numContours, 2}(xyCoordIndex, 2) = contourMatrix(i, 2);
      
      xyCoordIndex = xyCoordIndex + 1;
   end
   
   indexContourMatrix = indexContourMatrix + numZLevelPairs;
   
end

hold on 
for i = 1:numContours
    hPlot = plot (contourCellArray{i, 2}(:, 1), contourCellArray{i, 2}(:, 2)); 
    
    %bootstrap: if statements because cases won't
    %initiate in switch statement
    
    if contourCellArray{i, 3} > 0 && contourCellArray{i, 3} < 0.00002
        set (hPlot, 'Color', 'blue');
    end
    
    if contourCellArray{i, 3} > 0.00001 && contourCellArray{i, 3} < 0.00003
        set (hPlot, 'Color', 'cyan');
    end
    
    if contourCellArray{i, 3} > 0.00002 && contourCellArray{i, 3} < 0.00004
        set (hPlot, 'Color', 'green');
    end
    
    if contourCellArray{i, 3} > 0.00003 && contourCellArray{i, 3} < 0.00005
        set (hPlot, 'Color', 'yellow');
    end
    
    if contourCellArray{i, 3} > 0.00004 && contourCellArray{i, 3} < 0.00006
        set (hPlot, 'Color', [0.75, 0.1608, 0]);
    end
    
    if contourCellArray{i, 3} > 0.00005 && contourCellArray{i, 3} < 0.00007
        set (hPlot, 'Color', 'red');
    end
    
end

        
      