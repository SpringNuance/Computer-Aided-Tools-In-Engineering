function [] = printCheckedSupport(checkedSupport, units, reportFileID)
% Prints the support check report to a text file.

% Name
    fprintf(reportFileID,'%s\r\n',checkedSupport.name);
if checkedSupport.supportValidity == true    % Support data is right.
    % Correctness of the support
    fprintf(reportFileID,'Support is OK.\r\n');
    % Support number
    fprintf(reportFileID,'\tSupport number: %i',checkedSupport.number);
    fprintf(reportFileID,'\r\n'); % Newline
    % Node number
    nodeNumber = checkedSupport.nodeNumber;
    fprintf(reportFileID,'\tNode number: %i',nodeNumber);
    fprintf(reportFileID,'\r\n'); % Newline
end

% Node coordinate values
if checkedSupport.coVectorValidity == true
    x = checkedSupport.coVector(1);
    y = checkedSupport.coVector(2);
    fprintf(reportFileID,'Coordinate values are OK.\r\n');
    unit = units.dimension;
    formatSpec = '\tx%i = %+4.3f %s';
    fprintf(reportFileID,formatSpec,nodeNumber,x,unit);
    formatSpec = '\ty%i = %+4.3f %s\r\n';
    fprintf(reportFileID,formatSpec,nodeNumber,y,unit);
    %formatSpec = '\tx%i = %+4.3f %s';
else
    fprintf(reportFileID,'The coordinate values are WRONG.\r\n');
end

% Support conditions
% ux - fixed/free
if checkedSupport.coVectorValidity == true
    if checkedSupport.supportConditionValidity == true
        fprintf(reportFileID,'Boundary conditions are OK.\r\n');
    else
        fprintf(reportFileID,'Boundary conditions:\r\n');
    end
    % ux
    if checkedSupport.uxValidity == true
        fprintf(reportFileID,'\tux - %s\r\n',checkedSupport.ux);
    else
        fprintf(reportFileID,'\tux is WRONG.\r\n');
    end
    % uy
    if checkedSupport.uyValidity == true
        fprintf(reportFileID,'\tuy - %s\r\n',checkedSupport.uy);
    else
        fprintf(reportFileID,'\tuy is WRONG.\r\n');
    end
    % uz
    if checkedSupport.uzValidity == true
        fprintf(reportFileID,'\tuz - %s\r\n',checkedSupport.uz);
    else
        fprintf(reportFileID,'\tuz is WRONG.\r\n');
    end
    % phix
    if checkedSupport.phixValidity == true
        fprintf(reportFileID,'\tphix - %s\r\n',checkedSupport.phix);
    else
        fprintf(reportFileID,'\tphix is WRONG.\r\n');
    end
    % phiy
    if checkedSupport.phiyValidity == true
        fprintf(reportFileID,'\tphiy - %s\r\n',checkedSupport.phiy);
    else
        fprintf(reportFileID,'\tphiy is WRONG.\r\n');
    end
    % phiz
    if checkedSupport.phizValidity == true
        fprintf(reportFileID,'\tphiz - %s\r\n',checkedSupport.phiz);
    else
        fprintf(reportFileID,'\tphiz is WRONG.\r\n');
    end
end % (if)

fprintf(reportFileID,'\r\n'); % Newline

end % (function)