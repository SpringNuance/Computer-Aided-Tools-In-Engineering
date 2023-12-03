function unit = pickUpUnit(titleVector,rowNumber)
% Picks up the unit from heading row of the Excel file.

unitTitle = titleVector(rowNumber);      % Select the value of the vector.
unitText = string(unitTitle);            % Cell information as text
unit = extractBetween(unitText,"[","]"); % Picks up the contents of the square brackets.

end % (function)