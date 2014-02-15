%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:    displayNumberQDs
% 
% Version:     1.0
%
% Description: Displays the number of quantum dots on the current figure.
%
% Parameters:  numQDs - the number of quantum dots
%
% Returned:    None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function displayNumberQDs(numQDs)

hTextBox = annotation ('textbox', [NUM_QDS_X_POSITION, NUM_QDS_Y_POSITION, 0, 0]);
set (hTextBox, 'FitBoxToText', 'on');
set (hTextBox, 'String', strcat ('n = ', {' '}, int2str (numQDs)));
set (hTextBox, 'FontSize', 20);

end

