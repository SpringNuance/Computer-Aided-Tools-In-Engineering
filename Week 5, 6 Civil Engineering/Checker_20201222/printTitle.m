function [] = printTitle(reportFileID, files)
% Prints title data

% Printing header
fprintf(reportFileID,'C H E C K   R E P O R T\r\n');
fprintf(reportFileID,'Assignmet B3 - Frame\r\n');
fprintf(reportFileID,'\r\n');                                 % Leading

% Set and print the date and time
dayAndTime = now;
dAndT = datetime(dayAndTime,'ConvertFrom','datenum');
fprintf(reportFileID,'Created: %s\r\n',dAndT);
fprintf(reportFileID,'\r\n');                                 % Leading

% Printing files
fprintf(reportFileID,'Initial values file: %s\r\n',files.initialValuesFile);
fprintf(reportFileID,'Model file: %s\r\n\r\n',files.modelFile);

end % (function)

