function [] = checkResults(results, model, units, reportFileID)
% Check the correctness of the load combination
% Use function
% * printResults.m

% SELF-WEIGHT
checkedResults.LC1.name = results.LC1.name;
yRows = find(model.results.description=="Maximum displacement in Y-direction");
yRow = yRows(1);
yDeflection = model.results.value(yRow);
yUnit = model.results.unit(yRow);
if round(yDeflection,1) == round(results.LC1.value,1)  % Rounded to the nearest one digits.
    LC1.valueValidity = true;
    checkedResults.LC1.value = yDeflection;
else
    LC1.valueValidity = false;
end % (if)
if yUnit == units.deflection
    LC1.unitValidity = true;
else
    LC1.unitValidity = false;
end % (if)
checkedResults.LC1.valueValidity = LC1.valueValidity;
checkedResults.LC1.unitValidity = LC1.unitValidity;

% WIND
checkedResults.LC2.name = results.LC2.name;
xRows = find(model.results.description=="Maximum displacement in X-direction");
xRow = xRows(2);
xDeflection = model.results.value(xRow);
xUnit = model.results.unit(xRow);
if round(xDeflection,1) == round(results.LC2.value,1)  % Rounded to the nearest one digits.
    LC2.valueValidity = true;
    checkedResults.LC2.value = xDeflection;
else
    LC2.valueValidity = false;
end % (if)
if xUnit == units.deflection
    LC2.unitValidity = true;
else
    LC2.unitValidity = false;
    info = ['Change result deflection units to mm.'];
    disp(info)
end % (if)
checkedResults.LC2.valueValidity = LC2.valueValidity;
checkedResults.LC2.unitValidity = LC2.unitValidity;

% SNOW
checkedResults.LC3.name = results.LC3.name;
yRows = find(model.results.description=="Maximum displacement in Y-direction");
yRow = yRows(3);
yDeflection = model.results.value(yRow);
yUnit = model.results.unit(yRow);
if round(yDeflection,1) == round(results.LC3.value,1) % Rounded to the nearest one digits.
    LC3.valueValidity = true;
    checkedResults.LC3.value = yDeflection;
else
    LC3.valueValidity = false;
end % (if)
if yUnit == units.deflection
    LC3.unitValidity = true;
else
    LC3.unitValidity = false;
end % (if)
checkedResults.LC3.valueValidity = LC3.valueValidity;
checkedResults.LC3.unitValidity = LC3.unitValidity;

% Printing
printCheckedResults(checkedResults, units, reportFileID);   % Print to file

end % (function)