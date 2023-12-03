function [] = checkCo(CO, model, reportFileID)
% Checks the correctness of the load combiantion
% Use the funktion
% * printCheckedCo.m

[numRows,numCols] = size(table2array(model.co));
[numRowsCO,numColsCO] = size(CO);

if numRows == numRowsCO
    if table2array(model.co) == CO
        checkedCo.validity = true;
    else
        checkedCo.validity = false;
    end % (if)
    checkedCo.co = CO;
else
    info = ['Wrong number of load combinations.'];
    disp(info)
end

% Printing
printCheckedCo(checkedCo, reportFileID);   % Printing to file

end % (function)