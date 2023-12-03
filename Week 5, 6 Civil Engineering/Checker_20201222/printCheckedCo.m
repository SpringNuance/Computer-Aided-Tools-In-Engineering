function [] = printCheckedCo(checkedCo, reportFileID)
% Prints the load combination check report to a text file.

% Load combination case
    fprintf(reportFileID,'LOAD COMBINATION\r\n');
  
% Correctness of the load combination
if checkedCo.validity == true    % Combination data is right.
    fprintf(reportFileID,'Combination is OK.\r\n');
else
    fprintf(reportFileID,'Combination is WRONG.\r\n');
end % (if)

% Load cases of the combination
[rowNumber colNumber] = size(checkedCo.co);
for i = 1:rowNumber
    formatSpec = '\t%s\t%s\r\n';
    fprintf(reportFileID,formatSpec,checkedCo.co(i,1),checkedCo.co(i,2));
end % (for)
        
fprintf(reportFileID,'\r\n'); % Newline

end % (function)