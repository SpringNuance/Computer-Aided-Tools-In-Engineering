function [] = checkSupport(support, model, units, reportFileID)
% Check the correctness of the support
% Use function
% * printCheckedSupport.m

% Name
checkedSupport.name = support.name;

% Coordinates and node number
% Search for the same coordinates.
% -> Pick the corresponding node number.
% -> Pick the corresponding support number.
% -> Checking support conditions.
% If the coordinates do not match, an error message is issued.
NumberOfNodes = height(model.nodeCo.table); % Solmujen lukum‰‰r‰
for i = 1:NumberOfNodes
    x = model.nodeCo.table.x(i);
    y = model.nodeCo.table.y(i);
    coVector = [x y];
    if coVector == support.coVector             % Support coordinate values are right.
        checkedSupport.coVectorValidity = true;
        checkedSupport.coVector = coVector;
        nodeNumber = i;
        checkedSupport.nodeNumber = nodeNumber;   
        break
    else                                        % Support coordinate values are wrong.
        checkedSupport.coVectorValidity = false;
    end % (if)
end % (for)

% Support number
if checkedSupport.coVectorValidity == true      % Support coordinate values are right.
    NumberOfSupports = height(model.supports);  % Number of supports
    for i = 1:NumberOfSupports
        if nodeNumber == model.supports.nodeNumber(i)
            supportNumber = i;
            break
        end % (if)
    end % (for)
end % (if)
checkedSupport.number = supportNumber;

% Support conditions and their correctness
if checkedSupport.coVectorValidity == true      % Support coordinate values are right.
    % ux
    [checkedSupport.uxValidity, checkedSupport.ux] = ...
        checkBC(model.supports.ux(supportNumber), support.bCs.ux);
    % uy
    [checkedSupport.uyValidity, checkedSupport.uy] = ...
        checkBC(model.supports.uy(supportNumber), support.bCs.uy);
    % uz
    [checkedSupport.uzValidity, checkedSupport.uz] = ...
        checkBC(model.supports.uz(supportNumber), support.bCs.uz);
    % phix
    [checkedSupport.phixValidity, checkedSupport.phix] = ...
        checkBC(model.supports.phix(supportNumber), support.bCs.phix);
    % phiy
    [checkedSupport.phiyValidity, checkedSupport.phiy] = ...
        checkBC(model.supports.phiy(supportNumber), support.bCs.phiy);
    % phiz
    [checkedSupport.phizValidity, checkedSupport.phiz] = ...
        checkBC(model.supports.phiz(supportNumber), support.bCs.phiz);
end

% Correctness of the support conditions
if (checkedSupport.uxValidity == true) &...
        (checkedSupport.uyValidity == true) &...
        (checkedSupport.uzValidity == true) &...
        (checkedSupport.phixValidity == true) &...
        (checkedSupport.phiyValidity == true) &...
        (checkedSupport.phizValidity == true)
    checkedSupport.supportConditionValidity = true;          % Support conditions are right.
else
    checkedSupport.supportConditionValidity = false;         % Support conditions are wrong.
end % (if)

% Correctness of the support
if (checkedSupport.coVectorValidity == true) &...              
        (checkedSupport.supportConditionValidity == true)
    checkedSupport.supportValidity = true;                   % Support data is right.
else
    checkedSupport.supportValidity = false;                  % Support data is wrong.
end % (if)

% Printing
printCheckedSupport(checkedSupport, units, reportFileID);    % Print to file.

end % (function)