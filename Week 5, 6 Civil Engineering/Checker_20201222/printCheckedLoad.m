function [] = printCheckedLoad(checkedLoad, units, reportFileID)
% Prints the load combination check report to a text file.

% Load case
    fprintf(reportFileID,'%s\r\n',checkedLoad.case);
  
% Correctness of the load
if checkedLoad.loadValidity == true    % Load data is right.
    fprintf(reportFileID,'Loadcase is OK.\r\n');
end

% Load name
if checkedLoad.nameValidity == true
    fprintf(reportFileID,'Load name: %s',checkedLoad.name);
    fprintf(reportFileID,'\r\n'); % Newline
else
    fprintf(reportFileID,'Load name is WRONG.\r\n');
end % (if)
    
% Load category
if checkedLoad.categoryValidity == true
    fprintf(reportFileID,'Category: %s',checkedLoad.category);
    fprintf(reportFileID,'\r\n'); % Newline
else
    fprintf(reportFileID,'Load category is WRONG.\r\n');
end % (if)

% Presence in the calculation
if checkedLoad.presenceValidity == true
    fprintf(reportFileID,'Presence: %s',checkedLoad.presence);
    fprintf(reportFileID,'\r\n'); % Newline
else
    fprintf(reportFileID,'Load is NOT presence.\r\n');
end % (if)

% Activity
if checkedLoad.activityValidity == true
    fprintf(reportFileID,'Activity: %s',checkedLoad.activity);
    fprintf(reportFileID,'\r\n'); % Newline
else
    fprintf(reportFileID,'Load activity is NOT on or off.\r\n');
end % (if)
    
switch checkedLoad.case
    case 'LC1'
        % Load direction factor [x y z]
        if checkedLoad.dirFactorValidity == true
            fprintf(reportFileID,'Direction factors are OK.\r\n');
        else
            fprintf(reportFileID,'Direction factors have MISTAKE(S).\r\n');
        end % (if)
        % x
        if checkedLoad.dirFactorxValidity == true
            formatSpec = '\tx = %+2.1f\r\n';
            fprintf(reportFileID,formatSpec,checkedLoad.dirFactorx);
        else
            fprintf(reportFileID,'\tx-direction is WRONG.\r\n');
        end % (if)
        % y
        if checkedLoad.dirFactoryValidity == true
            formatSpec = '\ty = %+2.1f\r\n';
            fprintf(reportFileID,formatSpec,checkedLoad.dirFactory);
        else
            fprintf(reportFileID,'\ty-direction is WRONG.\r\n');
        end % (if)
        % z
        if checkedLoad.dirFactorzValidity == true
            formatSpec = '\tz = %+2.1f\r\n';
            fprintf(reportFileID,formatSpec,checkedLoad.dirFactorz);
        else
            fprintf(reportFileID,'\tz-direction is WRONG.\r\n');
        end % (if)
    case {'LC2', 'LC3'}
        % Load reference
        if checkedLoad.referenceValidity == true
            fprintf(reportFileID,'Reference: %s',checkedLoad.reference);
            fprintf(reportFileID,'\r\n'); % Newline
        else
            fprintf(reportFileID,'Reference is WRONG.\r\n');
        end % (if)
        % Load type, F/M
        if checkedLoad.typeValidity == true
            fprintf(reportFileID,'Type: %s',checkedLoad.type);
            fprintf(reportFileID,'\r\n'); % Newline
        else
            fprintf(reportFileID,'Type is WRONG.\r\n');
        end % (if)
        % Load distribution
        if checkedLoad.distributionValidity == true
            fprintf(reportFileID,'Distribution: %s',checkedLoad.distribution);
            fprintf(reportFileID,'\r\n'); % Newline
        else
            fprintf(reportFileID,'Distribution is WRONG.\r\n');
        end % (if)
        % Load direction
        if checkedLoad.directionValidity == true
            fprintf(reportFileID,'Direction: %s',checkedLoad.direction);
            fprintf(reportFileID,'\r\n'); % Newline
        else
            fprintf(reportFileID,'Direction is WRONG.\r\n');
        end % (if)
        % Load value
        if checkedLoad.valueValidity == true
            fprintf(reportFileID,'Value is OK.\r\n');
            formatSpec = '\tq_%s = %+4.3f %s\r\n';
            fprintf(reportFileID,formatSpec,lower(checkedLoad.name),...
                checkedLoad.value ,units.distributedForce);
        else
            fprintf(reportFileID,'Value is WRONG.\r\n');
        end % (if)
        % Point of action: Member
         if checkedLoad.nodesMatrixValidity == true
            fprintf(reportFileID,'Acting on member number: %i',checkedLoad.memberNumber);
            fprintf(reportFileID,'\r\n'); % Newline
        else
            fprintf(reportFileID,'Member for the load cannot be identifty.\r\n');
        end % (if)
    otherwise
        disp('Check the load cases!')
end % (switch)

fprintf(reportFileID,'\r\n'); % Newline

end % (function)