function [] = checkMember(member, model, units, reportFileID)
% Checks the correctness of the structural member.
% Use function
% * printCheckedMember.m

% LINE AND NODES
% Searching for line nodes.
% Checking the correctness of the nodes.
% The nodes in the model can be in the same or reverse order than
% the component derived from the initial data.
NumberOfLines = height(model.lines); % Number of lines
memberNodeCoMatrix = member.nodeCoMatrix;
for i = 1:NumberOfLines
    [nodesMatrixValidity, nodeCoTable] = checkNodes(memberNodeCoMatrix, model, i);
    lineNumber = i;                                  % Linenumber of the checked member
    if nodesMatrixValidity == true
        break
    end % (if)
end %(for)
% Nodes and coordinate values of the checked member
checkedMember.lineNumber = lineNumber; % Line number of the checked member
checkedMember.nodesMatrixValidity = nodesMatrixValidity;

checkedMember.nodeCoTable = nodeCoTable;       % Data according to the model
%nodesTable = array2table(nodeCoMatrix,'VariableNames',{'nodeNumber','x','y'});
%checkedMember.nodes.values = nodesTable;      % Data according to the model
% Determine the length if the nodes are correct, i.e., the line can be identified.
if checkedMember.nodesMatrixValidity == true
    checkedMember.L = member.L;
end % (if)

% MEMBER
% This is done only if the nodes are correct, i.e. the line can be identified.
if checkedMember.nodesMatrixValidity == true
    checkedMember.name = member.name;       % Member name
    checkedMember.class = member.class;     % Member class
    % Member number
    memberNumber = model.members.memberNumber(lineNumber);
    checkedMember.memberNumber = memberNumber; 
    % Member type
    memberType = model.members.memberType(lineNumber);
    memberType = string(memberType);        % Cell information into text
    checkedMember.memberType = memberType;  % Type of the checked member
    if memberType == member.type            % Member type is right.
        checkedMember.memberTypeValidity = true;    % 1, true
    else                                    % Member type is wrong.
        checkedMember.memberTypeValidity = false;   % 0, false
    end % (if)    
end % (if)

% CROSS-SECTIONS
% This is done only if the nodes are correct, i.e. the line can be identified.
if checkedMember.nodesMatrixValidity == true
    % Cross-section number at the beginning and end of the member
    cSstartNumber = model.members.startCSNumber(memberNumber);
    cStailNumber = model.members.tailCSNumber(memberNumber);
    cSNumber = cSstartNumber;
    if cSstartNumber == cStailNumber
        checkedMember.cS.numberValidity = true;
        checkedMember.cS.number = cSNumber;
    else
        checkedMember.cS.numberValidity = false;
    end
    % Assume that the cross section is constant and only the initial end is checked.
    % Shape of the cross-section
    name = model.cSs.table.name(cSNumber);
    % Check if the cross-sectional shape is included in the name.
    TF = contains(name,member.cS.shape);                % TF=TrueOrFalse=1/0
    if TF == 1                                          % Shape in right.
        checkedMember.cS.shapeValidity = true;
        checkedMember.cS.shape = member.cS.shape;
        % Width of the cross-section, d
        if model.cSs.table.d(cSNumber) == member.cS.d   % Width is right.
            checkedMember.cS.dValidity = true;
            checkedMember.cS.d = member.cS.d;
        else                                            % Width is wrong.
            checkedMember.cS.dValidity = false;
        end % (if)
        % Height of the cross-section, e
        if model.cSs.table.e(cSNumber) == member.cS.e   % Height is right.
            checkedMember.cS.eValidity = true;
            checkedMember.cS.e = member.cS.e;
        else                                            % Height is wrong.
            checkedMember.cS.eValidity = false;
        end % (if)
        % Correctness of cross section and cross section quantities
        if (checkedMember.cS.dValidity == true) &...    % Cross-section is right.
                (checkedMember.cS.eValidity == true)
            checkedMember.cS.validity = true;
            checkedMember.cS.A = member.cS.A;
            checkedMember.cS.Iz = member.cS.Iz;
        else                                            % Cross-section is wrong.
            checkedMember.cS.validity = false;
        end % (if)
    else                                                % Shape is wrong.
        checkedMember.cS.shapeValidity = false;
    end % (if)
end % (if)

% MATERIAL
% This is done only if the nodes are correct, i.e. the line can be identified.
if checkedMember.nodesMatrixValidity == true
    % Material number
    materialNumber = model.cSs.table.materialNumber(cSNumber);
    checkedMember.material.materialNumber = materialNumber;
    % Material name
    materialName = model.materials.table.materialName(materialNumber);
    materialName = string(materialName);         % Cell information into text. 
    checkedMember.material.name = materialName;  % Name of the checked material
    % Modulus of elasticity, E
    if model.materials.table.E(materialNumber)== member.material.E      % E is right.
        checkedMember.material.EValidity = true;
        checkedMember.material.E = member.material.E;
    else                                                                % E is wrong.
        checkedMember.material.EValidity = false;
    end % (if)
    % Poisson's ratio, nu
    if model.materials.table.nu(materialNumber)== member.material.nu    % nu is right.
        checkedMember.material.nuValidity = true;
        checkedMember.material.nu = member.material.nu;
    else
        checkedMember.material.nuValidity = false;                      % nu is wrong.
    end % (if)
    % Unit weight, gamma
    if model.materials.table.gamma(materialNumber) == member.material.gamma   % gamma is right.
        checkedMember.material.gammaValidity = true;
        checkedMember.material.gamma = member.material.gamma;
    else                                                                % gamma is wrong.
        checkedMember.material.gammaValidity = false;
    end
    % Material safety factor, gammaM
    if model.materials.table.gammaM(materialNumber) == member.material.gammaM   % gammaM is right.
        checkedMember.material.gammaMValidity = true;
        checkedMember.material.gammaM = member.material.gammaM;
    else                                                                % gammaM is wrong.
        checkedMember.material.gammaMValidity = false;
    end % (if)
    % Material model
    materialModel = model.materials.table.materialModel(materialNumber);
    materialModel = string(materialModel);              % Cell information into text.
    if materialModel == member.material.materialModel   % Material model is right.
        checkedMember.material.materialModelValidity = true;
        checkedMember.material.materialModel = materialModel; % Name of the checked material.
    else                                                      % Material model is wrong.
        checkedMember.material.materialModelValidity = false;
    end % (if)
    % Material correctness, shear modulus and structure weight
    if (checkedMember.material.EValidity == true) &...              % Material is right.
            (checkedMember.material.nuValidity == true) &...
            (checkedMember.material.gammaValidity == true) &...
            (checkedMember.material.gammaMValidity == true) &...
            (checkedMember.material.materialModelValidity == true)
        checkedMember.material.validity = true;
        checkedMember.material.G = member.material.G;
        checkedMember.mass = member.mass;
    else
        checkedMember.material.validity = false;                    % Material is wrong.
    end % (if)
end % (if)

% Member correctness
if (checkedMember.nodesMatrixValidity == true) &...              
        (checkedMember.memberTypeValidity == true) &...
        (checkedMember.cS.validity == true) &...
        (checkedMember.material.validity == true)
    checkedMember.memberValidity = true;                % Member is right.
else
    checkedMember.memberValidity = false;               % Member is wrong.
end % (if)

% PRINTING
printCheckedMember(checkedMember, units, reportFileID); % Print to file.

end % (function)