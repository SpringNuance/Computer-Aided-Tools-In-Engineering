function [] = printCheckedResults(checkedResults, units, reportFileID)
% Prints the results check report to a text file.

% Heading
fprintf(reportFileID,'RESULTS\r\n');

% LC1
fprintf(reportFileID,'%s\r\n',checkedResults.LC1.name);

% Correctness of deflection
if checkedResults.LC1.valueValidity == true && checkedResults.LC1.unitValidity == true
    fprintf(reportFileID,'Deflection at the mid of the beam is OK.\r\n');
    formatSpec = '\tv = %+4.2f %s\r\n';
    fprintf(reportFileID,formatSpec,checkedResults.LC1.value,units.deflection);
else
    fprintf(reportFileID,'Deflection at the mid of the beam is WRONG.\r\n');
end % (if)

% LC2
fprintf(reportFileID,'%s\r\n',checkedResults.LC2.name);

% Correctness of deflection
if checkedResults.LC2.valueValidity == true && checkedResults.LC2.unitValidity == true
    fprintf(reportFileID,'Deflection at the top of the column is OK.\r\n');
    formatSpec = '\tu = %+4.2f %s\r\n';
    fprintf(reportFileID,formatSpec,checkedResults.LC2.value,units.deflection);
else
    fprintf(reportFileID,'Deflection at the top of the column is WRONG.\r\n');
end % (if)

% LC3
fprintf(reportFileID,'%s\r\n',checkedResults.LC3.name);

% Correctness of deflection
if checkedResults.LC3.valueValidity == true && checkedResults.LC3.unitValidity == true
    fprintf(reportFileID,'Deflection at the mid of the beam is OK.\r\n');
    formatSpec = '\tv = %+4.2f %s\r\n';
    fprintf(reportFileID,formatSpec,checkedResults.LC3.value,units.deflection);
else
    fprintf(reportFileID,'Deflection at the mid of the beam is WRONG.\r\n');
end % (if)

fprintf(reportFileID,'\r\n'); % Newline

end % (function)