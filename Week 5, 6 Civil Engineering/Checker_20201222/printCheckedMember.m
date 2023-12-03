function [] = printCheckedMember(checkedMember, units, reportFileID)
% Prints the component check report to a text file.

% MEMBER
if checkedMember.nodesMatrixValidity == true    % Node coordinate values are right.
    % Name
    fprintf(reportFileID,'%s\r\n',checkedMember.name);
    % Correctness
    if checkedMember.memberValidity == true
        fprintf(reportFileID,'Member is OK.\r\n');
    end % (if)
    % Member number
    fprintf(reportFileID,'\tNumber: %i',checkedMember.memberNumber);
    fprintf(reportFileID,'\r\n'); % Newline
    % Class
    memberClass = checkedMember.class;
    fprintf(reportFileID,'\tClass: %s\r\n',memberClass);
    % Member type
    if checkedMember.memberTypeValidity == true
        fprintf(reportFileID,'\tType, which set the elemnent type: ');
        fprintf(reportFileID,'%s\r\n',checkedMember.memberType);
    else
        fprintf(reportFileID,'Member type: %s is WRONG.\r\n');
    end
    if checkedMember.material.validity == true
        fprintf(reportFileID,'\tMass: ');
        formatSpec = 'W = %4.3f %s\r\n';
        fprintf(reportFileID,formatSpec,checkedMember.mass,units.mass);    
    end
end % (if)

% LINE AND NODES
% Correctness of the line and line number
if checkedMember.nodesMatrixValidity == true    % Node coordinate values are right.
    fprintf(reportFileID,'Line is OK.\r\n');
    fprintf(reportFileID,'\tNumber: %i',checkedMember.lineNumber);
    fprintf(reportFileID,'\r\n'); % Newline
    fprintf(reportFileID,'\tLength: ');
    formatSpec = 'L = %4.3f %s';
    fprintf(reportFileID,formatSpec,checkedMember.L,units.dimension);
    fprintf(reportFileID,'\r\n');  % Newline
end % (if)

% Nodes
unit = units.dimension;
n1 = checkedMember.nodeCoTable.nodeNumber(1);
n2 = checkedMember.nodeCoTable.nodeNumber(2);
x1 = checkedMember.nodeCoTable.x(1);
y1 = checkedMember.nodeCoTable.y(1);
x2 = checkedMember.nodeCoTable.x(2);
y2 = checkedMember.nodeCoTable.y(2);
if checkedMember.nodesMatrixValidity == true    % Node coordinate values are right. 
    formatSpec = 'Nodepoints %i and %i are OK.\r\n';
    fprintf(reportFileID,formatSpec,n1,n2);
else                                            % Node coordinate values are wrong.
    formatSpec = 'The member cannot be identifty. These nodepoints are WRONG:\r\n'
    fprintf(reportFileID,formatSpec);
end % (if)    
formatSpec = '\tx%i = %+4.3f %s';
fprintf(reportFileID,formatSpec,n1,x1,unit);
formatSpec = '\ty%i = %+4.3f %s\r\n';
fprintf(reportFileID,formatSpec,n1,y1,unit);
formatSpec = '\tx%i = %+4.3f %s';
fprintf(reportFileID,formatSpec,n2,x2,unit);
formatSpec = '\ty%i = %+4.3f %s';
fprintf(reportFileID,formatSpec,n2,y2,unit);
fprintf(reportFileID,'\r\n');                   % Newline

% Length of the line
if checkedMember.nodesMatrixValidity == true    % Node coordinate values are right.
% *** ??? 
end % (if)

% CROSS-SECTIONS
if checkedMember.nodesMatrixValidity == true    % Node coordinate values are right.
    if checkedMember.cS.validity == true
        fprintf(reportFileID,'Cross-section is OK.\r\n');
    elseif checkedMember.cS.shapeValidity == true
        fprintf(reportFileID,'Cross-section shape is OK.\r\n');
    else
        % fprintf(reportFileID,'Cross-section dimensions have ERRORS.\r\n');
    end % (if)
    % Cross-section number at the beginning and end of the member
    if checkedMember.cS.numberValidity == true
        formatSpec = '\tNumber: %i\r\n';
        fprintf(reportFileID,formatSpec,checkedMember.cS.number);
    else
        fprintf(reportFileID,'Cross-section number is WRONG.\r\n');
    end
    % For a valid cross-section
    % Cross-section shape
    if checkedMember.cS.shapeValidity == true
        formatSpec = '\t%s\r\n';
        fprintf(reportFileID,formatSpec,checkedMember.cS.shape);
    end % (if)
    % Width of the cross-section, d
    if checkedMember.cS.dValidity == true
        formatSpec = '\td = %4.3f %s';
        fprintf(reportFileID,formatSpec,checkedMember.cS.d,units.dimension);
        if memberClass == "Column"
            fprintf(reportFileID,' (width in x-direction)\r\n');
        elseif memberClass == "Beam"
            fprintf(reportFileID,' (width in z-direction)\r\n');
        end
    else
        fprintf(reportFileID,'Cross-section width is WRONG.\r\n');
    end % (if)
    % Height of the cross-section, e
    if checkedMember.cS.eValidity == true
        formatSpec = '\te = %4.3f %s';
        fprintf(reportFileID,formatSpec,checkedMember.cS.e,units.dimension);
        if memberClass == "Column"
            fprintf(reportFileID,' (height in z-direction)\r\n');
        elseif memberClass == "Beam"
            fprintf(reportFileID,' (height in y-direction)\r\n');
        end
    else
        fprintf(reportFileID,'Cross-section height e is WRONG.\r\n');
    end % (if)
    % Area A and moment of inertia Iz of the cross-section
    if checkedMember.cS.validity == true
        formatSpec = '\tA = %4.3f %s\r\n';
        fprintf(reportFileID,formatSpec,checkedMember.cS.A,units.area);
        formatSpec = '\tIz = %4.6f %s\r\n';
        fprintf(reportFileID,formatSpec,checkedMember.cS.Iz,units.momentOfInertia);
    end % (if)
end % (if)

% MATERIAL
% *** ??? If ok, the mass is printed
if checkedMember.nodesMatrixValidity == true    % Node coordinate values are right.
    % Oikeaksi todetulle materiaalille
    if checkedMember.material.validity == true
        fprintf(reportFileID,'Matrial is OK.\r\n');
    else
        % fprintf(reportFileID,'Material is WRONG.\r\n');
    end % (if)
    % Material number
    formatSpec = '\tNumber: %i\r\n';
    fprintf(reportFileID,formatSpec,checkedMember.material.materialNumber); 
    % Material name
    formatSpec = '\t%s\r\n';
    fprintf(reportFileID,formatSpec,checkedMember.material.name);
    % Material model
    if checkedMember.material.materialModelValidity == true
        formatSpec = '\t%s\r\n';
    fprintf(reportFileID,formatSpec,checkedMember.material.materialModel);
    else
        fprintf(reportFileID,'Material model is WRONG.\r\n');
    end % (if)
    % Modulus of elasticity E
    if checkedMember.material.EValidity == true
        formatSpec = '\tE = %4.3f %s\r\n';
        fprintf(reportFileID,formatSpec,checkedMember.material.E,units.stress);
    else
        fprintf(reportFileID,'Modulus of elasticity E is WRONG.\r\n');
    end % (if)
    % Poisson's ratio, nu
    if checkedMember.material.nuValidity == true
        formatSpec = '\tnu = %4.3f\r\n';
        fprintf(reportFileID,formatSpec,checkedMember.material.nu);
    else
        fprintf(reportFileID,'Poisson''s ratio is WRONG.\r\n');
    end % (if)
    % Shear modulus, G
    if (checkedMember.material.EValidity == true) &...
            (checkedMember.material.nuValidity == true)
        formatSpec = '\tG = %4.3f %s\r\n';
        fprintf(reportFileID,formatSpec,checkedMember.material.G,units.stress);
    end % (if)
    % Unit weight, gamma
    if checkedMember.material.gammaValidity == true
        formatSpec = '\tgamma = %4.3f %s\r\n';
        fprintf(reportFileID,formatSpec,checkedMember.material.gamma,units.unitWeight);
    else
        fprintf(reportFileID,'Unit weight gamma is WRONG.\r\n');
    end % (if)
    % Safety factor of the material, gammaM
    if checkedMember.material.gammaMValidity == true
        formatSpec = '\tgammaM = %4.3f %s\r\n';
        fprintf(reportFileID,formatSpec,checkedMember.material.gammaM);
    else
        fprintf(reportFileID,'Partial safety factor of the material is WRONG.\r\n');
    end % (if)
    fprintf(reportFileID,'\r\n'); % Newline
end % (if)
fprintf(reportFileID,'\r\n'); % Newline

end % (function)