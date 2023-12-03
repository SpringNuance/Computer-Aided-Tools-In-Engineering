function [nodesMatrixValidity, nodeCoTable] = ...
    checkNodes(nodeCoMatrix, model, lineNumber)
% Checks the correctness of the line nodes

% Searching for line nodes.
% Checking the correctness of the nodes.
% The nodes in the model can be in the same or reverse order than
% the component derived from the initial skills.

endNodesNumber = model.lines.endNodesNumber(lineNumber);  % Nodes as a matrix of one cell
str = string(endNodesNumber);                   % Cell information into text
endNodesTextVector = split(str,",");            % Text as a vertical vector of two cells
startNode = str2num(endNodesTextVector(1));     % Forward (start) end node
tailNode = str2num(endNodesTextVector(2));      % Tail node
x1 = model.nodeCo.table.x(startNode);           % The x-coordinate of the forward node
y1 = model.nodeCo.table.y(startNode);           % The y-coordinate of the forward node
x2 = model.nodeCo.table.x(tailNode);            % The x-coordinate of the tail node
y2 = model.nodeCo.table.y(tailNode);            % The y-coordinate of the tail node
modelNodeCoMatrix = [x1 y1; x2 y2];             % Coordinate values in matrix format
modelNodeCoMatrix2 = [x2 y2; x1 y1];            % Nodes in reverse order
%nodeCoMatrix
% Nodes in the same order
if modelNodeCoMatrix == nodeCoMatrix            % Node coordinate values are right.
   nodesMatrixValidity = true;                  % 1, true.
% Nodes in reverse order. (Matrices cannot be compared
% using the or-clause. Tables cannot be compared using the if-statement.)
elseif modelNodeCoMatrix2 == nodeCoMatrix       % Node coordinate values are right.  
   nodesMatrixValidity = true;                  % 1, true.
else                                            % Node coordinate values are wrong.
   nodesMatrixValidity = false;                 % 0, fail.
end % (if)

% Make a table of node numbers and coordinate values
nodeNumber = [startNode; tailNode];             % Node vector
x = [x1; x2];                                   % x-vector
y = [y1; y2];                                   % y-vector
nodeCoTable = table(nodeNumber, x, y);

end % (function)