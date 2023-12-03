function [] = checkLoad(load, model, units, reportFileID)
% Checks the correctness of the load.
% Use function
% * printCheckedLoad.m

% Load case
loadCase = load.case;
checkedLoad.case = loadCase;

% Line numbers. Assumed that are always in numerical order.
switch load.case
    case 'LC1'
        rowNumber = 1;
    case 'LC2'
        rowNumber = 2;
    case 'LC3'
        rowNumber = 3;
    otherwise
        disp('Check the load cases!')
end % (switch)

% Name
modelLoadName = string(model.loads.loaddName(rowNumber));   % Cell information into text 
loadName = string(load.name);                               % Cell information into text
if lower(modelLoadName) == lower(loadName)                  % Letters can be uppercase or lowercase.
    checkedLoad.nameValidity = true;
    checkedLoad.name = load.name;
else
    checkedLoad.nameValidity = false;
end % (if)

% Category
if string(model.loads.category(rowNumber)) == string(load.category)
    checkedLoad.categoryValidity = true;
    checkedLoad.category = load.category;
else
    checkedLoad.categoryValidity = false;
end % (if)

% Presence in calculation
[checkedLoad.presenceValidity, checkedLoad.presence] = ...
    checkPresence(model.loads.presence(rowNumber), load.presence);

% Aktiivisuus, vain omapaino "+", muilla "-"
[checkedLoad.activityValidity, checkedLoad.activity] = ...
    checkPresence(model.loads.activity(rowNumber), load.activity);

switch load.case
    case 'LC1'
        % Direction factors
        % x
        if model.loads.x(rowNumber) == load.dirFactors(1)
            checkedLoad.dirFactorxValidity = true;
            checkedLoad.dirFactorx = load.dirFactors(1);
        else
            checkedLoad.dirFactorxValidity = false;
        end % (if)
        % y
        if model.loads.y(rowNumber) == load.dirFactors(2)
            checkedLoad.dirFactoryValidity = true;
            checkedLoad.dirFactory = load.dirFactors(2);
        else
            checkedLoad.dirFactoryValidity = false;
        end % (if)
        % z
        if model.loads.z(rowNumber) == load.dirFactors(3)
            checkedLoad.dirFactorzValidity = true;
            checkedLoad.dirFactorz = load.dirFactors(3);
        else
            checkedLoad.dirFactorzValidity = false;
        end % (if)
        if (checkedLoad.dirFactorxValidity == true) &...
                (checkedLoad.dirFactoryValidity == true) &...
                (checkedLoad.dirFactorzValidity == true)
            checkedLoad.dirFactorValidity = true;         % Direction factors are right.
        else
            checkedLoad.dirFactorValidity = false;        % Direction factors are wrong.
        end % (if)
    case 'LC2'
        % Load referency
        if string(model.LC2.reference) == string(load.reference)
            checkedLoad.referenceValidity = true;
            checkedLoad.reference = load.reference;
        else
            checkedLoad.referenceValidity = false;
        end % (if)
        % Load type F/M
        if string(model.LC2.type) == string(load.type)
            checkedLoad.typeValidity = true;
            checkedLoad.type = load.type;
        else
            checkedLoad.typeValidity = false;
        end % (if)
        % Load distribution
        if string(model.LC2.distribution) == string(load.distribution)
            checkedLoad.distributionValidity = true;
            checkedLoad.distribution = load.distribution;
        else
            checkedLoad.distributionValidity = false;
        end % (if)
        % Load direction
        if string(model.LC2.direction) == string(load.direction)
            checkedLoad.directionValidity = true;
            checkedLoad.direction = load.direction;
        else
            checkedLoad.directionValidity = false;
        end % (if)
        % Load value
        if model.LC2.value == load.value
            checkedLoad.valueValidity = true;
            checkedLoad.value = load.value;
        else
            checkedLoad.valueValidity = false;
        end % (if)
        % Acting point: Node numbers and coordinate values [n1 x1 y1; n2 x2 y2]
        loadNodeMatrix = load.nodeMatrix;                           % Node matrix
        memberNumber = model.LC2.memberNumber;                      % Member number
        lineNumber = model.members.lineNumber(memberNumber);        % Line number
        endNodeNumbers = model.lines.endNodesNumber(lineNumber);    % Node number
        % Checking nodes
        [nodesMatrixValidity, nodeCoTable] = checkNodes(loadNodeMatrix, model, lineNumber);
        checkedLoad.nodesMatrixValidity = nodesMatrixValidity;
        checkedLoad.memberNumber = memberNumber;
    case 'LC3'
        % Load reference
        if string(model.LC3.reference) == string(load.reference)
            checkedLoad.referenceValidity = true;
            checkedLoad.reference = load.reference;
        else
            checkedLoad.referenceValidity = false;
        end % (if)
        % Load type F/M
        if string(model.LC3.type) == string(load.type)
            checkedLoad.typeValidity = true;
            checkedLoad.type = load.type;
        else
            checkedLoad.typeValidity = false;
        end % (if)
        % Load distribution
        if string(model.LC3.distribution) == string(load.distribution)
            checkedLoad.distributionValidity = true;
            checkedLoad.distribution = load.distribution;
        else
            checkedLoad.distributionValidity = false;
        end % (if)
        % Load direction
        if string(model.LC3.direction) == string(load.direction)
            checkedLoad.directionValidity = true;
            checkedLoad.direction = load.direction;
        else
            checkedLoad.directionValidity = false;
        end % (if)
        % Load value
        if model.LC3.value == load.value
            checkedLoad.valueValidity = true;
            checkedLoad.value = load.value;
        else
            checkedLoad.valueValidity = false;
        end % (if)
        % Acting point: Node numbers and coordinate values [n1 x1 y1; n2 x2 y2]
        loadNodeMatrix = load.nodeMatrix;                           % Node matrix
        memberNumber = model.LC3.memberNumber;                      % Member number
        lineNumber = model.members.lineNumber(memberNumber);        % Line number
        endNodeNumbers = model.lines.endNodesNumber(lineNumber);    % Node number
        % Checking nodes
        [nodesMatrixValidity, nodeCoTable] = checkNodes(loadNodeMatrix, model, lineNumber);
        checkedLoad.nodesMatrixValidity = nodesMatrixValidity;
        checkedLoad.memberNumber = memberNumber;
    otherwise
        disp('Check the load cases!')
end % (switch)

% Correctness of the load
switch load.case
    case 'LC1'
        if (checkedLoad.nameValidity == true) &...
                (checkedLoad.categoryValidity == true) &...
                (checkedLoad.presenceValidity == true) &...
                (checkedLoad.activityValidity == true) &...
                (checkedLoad.dirFactorValidity == true)
            checkedLoad.loadValidity = true;         % Load data is right.
        else
            checkedLoad.loadValidity = false;        % Load data is wrong.
        end % (if)
    case {'LC2', 'LC3'}
        if (checkedLoad.nameValidity == true) &...
                (checkedLoad.categoryValidity == true) &...
                (checkedLoad.presenceValidity == true) &...
                (checkedLoad.activityValidity == true) &...
                (checkedLoad.referenceValidity == true) &...
                (checkedLoad.typeValidity == true) &...
                (checkedLoad.distributionValidity == true) &...
                (checkedLoad.directionValidity == true) &...
                (checkedLoad.valueValidity == true) &...
                (checkedLoad.nodesMatrixValidity == true)
            checkedLoad.loadValidity = true;        % Load data is right.
        else
            checkedLoad.loadValidity = false;       % Load data is wrong.
        end % (if)
    otherwise
        disp('Check the load cases!')
end % (switch)

% Printing
printCheckedLoad(checkedLoad, units, reportFileID);   % Printing to file.

end % (function)