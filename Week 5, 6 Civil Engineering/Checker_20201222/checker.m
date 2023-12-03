% C H E C K E R   -   T A R K I S T I N
% Assignment B3 - Concrete Frame
%
% Limitations
% - The coordinate system and the location of the structure are in 
%   accordance with assigment instructions.
% - The program does not check the items mentioned later in this file.
% 
% Description
% - The following are created from the input data
%   A) Three structural members:
%       1) left column
%       2) right colmun
%       3) beam
%      Use the funtion 
%       * createMember.m
%   B) Two supports:
%       1) left column
%       2) right colmun
%      Use the funtion 
%       * createSupport.m
%   C) Three load cases:
%       1) LC1, self-weight
%       2) LC2, wind
%       3) LC3, snow
%      Use the funtion 
%       * createLoad.m
%   D) Load Combination (CO)
%   E) Results at selected points
% - The model and the input data are compared by creating 
%   a description of the comparison results:
%   A) Structural memeber (chekkedMember)
%      Use the funtion 
%       * checkMember.m
%   B) Support (chekkedSupport)
%      Use the funtion 
%       * checkSupport.m
%   C) Loading (chekkedLoad)
%      Use the funtion 
%       * checkLoad.m
%   D) Load Combination (CO)
%      Use the funtion 
%       * checkCo.m
%   E) Results at selected points
%      Use the funtion 
%       * checkResults.m
% - Three points are checked on the results:
%   1) LC1, self-weight, deflection at the mid of the beam
%   2) LC2, wind, deflection at the top of the column
%   3) LC3, snow, deflection at the mid of the beam
% - The results of the comparison are recorded in a report.
%   Use the funtions 
%   * printTitle.m
%   * printChecedkMember.m, jota kutsutaan funktiosta checkMember.m
%   * printChecedkSupport.m, jota kutsutaan funktiosta checkSupport.m
%   * printChecedkLoad.m, jota kutsutaan funktiosta checkLoad.m
%   * printChecedkCO.m, jota kutsutaan funktiosta checkLoad.m
%   * printChecedkResults.m, jota kutsutaan funktiosta checkResults.m

% CLEARING MEMORY
clear

% FILES
% Arrange the data in the form of a structure table
files.initialValuesFile = ('12345M.xlsx');    % Initial values
files.reportFile = ('report.txt');            % Report
files.modelFile = ('B3_Frame.xlsx');          % Model

% Name the sheets in the model file
modelFile.nodesSheet = ('1.1 Nodes');
modelFile.linesSheet = ('1.2 Lines');
modelFile.materialsSheet = ('1.3 Materials');
modelFile.nodalSupportsSheet = ('1.7 Nodal Supports');
modelFile.crossSectionsSheet = ('1.13 Cross-Sections '); % NB. Space at the end.
modelFile.membersSheet = ('1.17 Members');
% Not checked: 1.23 FE Mesh Refinements
modelFile.loadCasesSheet = ('2.1 Load Cases');
% Not checked: 2.2 Actions
% Not checked: 2.3 Combination Expressions
% Not checked: 2.4 Action Combinations
modelFile.loadCoSheet = ('2.5 Load Combinations');
% Not checked: 2.6 Result Combinations
modelFile.LC2Sheet = ('LC2 - 3.2 Member Loads');
modelFile.LC3Sheet = ('LC3 - 3.2 Member Loads');
modelFile.resultsSheet = ('LC1 - 4.0 Results - Summary');

% Model file sheets
modelSheets = sheetnames(files.modelFile);

% Starting row (in Excel file)
% Each data table always starts on the same row. Headings on rows 1 and 2.
startRow = 3;

% INITIAL DATA
% Units
% Arrange the data in the form of a structure table.

% Initial data given in the task (intial values file)
% The program does not check these for correctness and does not convert to another.
% Dimension
[LTitle] = readvars(files.initialValuesFile,'Range',[1 2 2 2]);
units.dimension = pickUpUnit(LTitle,2);   % b, h, L, x, y
% Distiributed force
[qTitle] = readvars(files.initialValuesFile,'Range',[1 11 2 11]);
units.distributedForce = pickUpUnit(qTitle,2);   % q, p
% Stress
[ETitle] = readvars(files.initialValuesFile,'Range',[1 8 2 8]);
units.stress = pickUpUnit(ETitle,2);   % E, G
% Unit weight
[gammaTitle] = readvars(files.initialValuesFile,'Range',[1 10 2 10]);
units.unitWeight = pickUpUnit(gammaTitle,2);   % gamma

% Other units
units.deflection = "mm";            % u, v
units.area = "m^2";                 % A
units.momentOfInertia = "m^4";      % I
units.mass = "kg";                  % W
units.acceleration = "m/s^2";       % g

% Global variables
global g;
g = 10; % m/s^2. Gravity acceleration, value used by RFEM. (Tarkka arvo 9,81.)

% Definition of variables
% Lb - Length of the beam
% Lc - Length of the column
% db - Width of the beam cross-section
% dc - Width of the column cross-section
% eb - Height of the beam cross-section
% ec - Height of the column cross-section
% E - Modulus of elasticity
% nu - Poisson's ratio
% gamma - Unit weight
% gammaM - Partial safety factor of the material
% p - Wind load
% q - Snow load
[Lb,Lc,db,dc,eb,ec,E,nu,gamma,q,p] = readvars(files.initialValuesFile,'Range',[startRow, 2, startRow, 12]); % 'B3:L3'
gammaM = 1;

% STRUCTURAL MEMBERS ON GROUNDS OF INITIAL DATA
% Arrange the data in the form of a structure table.

% Left column
leftColumn = createMember(...
    'LEFT COLUMN',...               % Member name
    'Column',...                    % Class
    'Beam',...                      % Type
    [0 0; 0 -Lc],...                % Coordinate value matrix [x1 y1; x2 y2]
    Lc,...                          % Length
    'Rectangle',...                 % Shape of the cross section
    dc,...                          % Width of the cross section
    ec,...                          % Height of the cross section
    'Concrete',...                  % Material
    E,...                           % Modulus of elasticity
    nu,...                          % Poisson's ratio
    gamma,...                       % Unit weight
    gammaM,...                      % Partial safety factor of the material
    'Isotropic Linear Elastic');    % Material model

% Right column
rightColumn = createMember(...
    'RIGHT COLUMN',...              % Member name
    'Column',...                    % Class
    'Beam',...                      % Type
    [Lb 0; Lb -Lc],...              % Coordinate value matrix [x1 y1; x2 y2]
    Lc,...                          % Length
    'Rectangle',...                 % Shape of the cross section
    dc,...                          % Width of the cross section
    ec,...                          % Height of the cross section
    'Concrete',...                  % Material
    E,...                           % Modulus of ealsticity
    nu,...                          % Poisson's ratio
    gamma,...                       % Unit weight
    gammaM,...                      % Partial safety factor of the material
    'Isotropic Linear Elastic');    % Material model

% Beam
beam = createMember(...
    'BEAM',...                      % Member name
    'Beam',...                      % Class
    'Beam',...                      % Type
    [0 -Lc; Lb -Lc],...             % Coordinate value matrix [x1 y1; x2 y2]
    Lb,...                          % Length
    'Rectangle',...                 % Shape of the cross section
    db,...                          % Width of the cross section
    eb,...                          % Height of the cross section
    'Concrete',...                  % Material
    E,...                           % Modulus of elasticity
    nu,...                          % Poisson's ratio
    gamma,...                       % Unit weihght
    gammaM,...                      % Partial safety factor of the material
    'Isotropic Linear Elastic');    % Material model

% SUPPORTS ON GROUNDS OF INITIAL DATA
% Arrange the data in the form of a structure table.

% Left support
leftSupport = createSupport(...
    'LEFT SUPPORT',...              % Name
    ["+" "+" "+" "+" "+" "+"],...   % Support conditions: generalized dispalcement prevented in all directions
    [0 0]);                         % Coordinate value vector [x1 y1]
    
% Right support
rightSupport = createSupport(...
    'RIGHT SUPPORT',...             % Name
    ["+" "+" "+" "+" "+" "+"],...   % Support conditions: generalized dispalcement prevented in all directions
    [Lb 0]);                        % Coordinate value vector [x1 y1]

% LOADING ON GROUNDS OF INITIAL DATA

% LC1 - Self weight
% Mass is calculated in structural member.
LC1 = createDeadLoad(...
    "LC1",...           % Load case
    'Self-weight',...   % Load name
    'Permanent',...     % Classification
    "+",...             % Presence in the calculation
    "+",...             % Activity (+ only for self weight)
    [0 1 0]);           % Dirction factory [x y z]

% LC2 - Tuuli p
LC2 = createLoad(...
    'LC2',...           % Load case
    'Wind',...          % Load name
    'Wind',...          % Classification
    "+",...             % Presence in the calculation
    "-",...             % Activity
    'Members',...       % Referency
    'Force',...         % Generalized force
    'Uniform',...       % Distribution
    'XL',...            % Direction of influence
    p,...               % Magnitude
    [0 0; 0 -Lc]);      % Acting point: values in matrix [x1 y1; x2 y2]

% LC3 - Snow q
LC3 = createLoad(...
    'LC3',...                       % Load case
    'Snow',...                      % Load name
    'Snow - s-k < 2.75 kN/m^2',...  % Classification
    "+",...                         % Presence in the calculation
    "-",...                         % Activity
    'Members',...                   % Referency
    'Force',...                     % Generalized force
    'Uniform',...                   % Distribution
    'YL',...                        % Direction of influence
    q,...                           % Magnitude
    [0 -Lc; Lb -Lc]);               % Acting point: values in matrix [x1 y1; x2 y2]

% Load Combination
CO = ["CO1", "1.35*LC1";...
    "CO2", "1.15*LC1 + 1.5*LC2";...
    "CO3", "1.15*LC1 + 1.5*LC2 + 1.05*LC3";...
    "CO4", "1.15*LC1 + 1.5*LC3";...
    "CO5", "1.15*LC1 + 0.9*LC2 + 1.5*LC3";...
    "CO6", "LC1";...
    "CO7", "LC1 + LC2";...
    "CO8", "LC1 + LC2 + 0.7*LC3";...
    "CO9", "LC1 + LC3";...
    "CO10", "LC1 + 0.6*LC2 + LC3";...
    "CO11", "LC1";...
    "CO12", "LC1 + 0.2*LC2";...
    "CO13", "LC1 + 0.2*LC2 + 0.2*LC3";...
    "CO14", "LC1 + 0.4*LC3";...
    "CO15", "LC1";...
    "CO16", "LC1 + 0.2*LC3"];

% MODEL TO CHECK
% Compilation of information to be checked
% Arrange the data in the form of a structure table.

% Read the NODE POINTS
% + Units (x, y)
% + Number
% + x- and y-coordinate
% Not to be read
% - node type
% - reference node
% - cross-sectional system
% - z-coordinate
if sum(contains(modelSheets,modelFile.nodesSheet)) == 1 % The sheet exist
    [xTitle] = readvars(files.modelFile,'Sheet',modelFile.nodesSheet,'Range',[1 5 2 5]); % E
    model.nodeCo.unit = pickUpUnit(xTitle,2);
    [nodeNumber] = readvars(files.modelFile,'Sheet',modelFile.nodesSheet,'Range','A:A');
    [numRows,numCols] = size(nodeNumber);
    endRow = numRows+(startRow-1);
    [x,y] = readvars(files.modelFile,'Sheet',modelFile.nodesSheet,'Range',[startRow, 5, endRow, 6]); % E:F
    model.nodeCo.table = table(nodeNumber,x,y);
else
    info = ['Sheet ',modelFile.nodesSheet,' is missing.'];
    disp(info)
end % (if)

% Reading LINES
% + number
% + end nodes (2 pcs)
% Not to be read
% - line type
% length. The length is ok if the nodes are ok.
if sum(contains(modelSheets,modelFile.linesSheet)) == 1 % The sheet exist
    [lineNumber] = readvars(files.modelFile,'Sheet',modelFile.linesSheet,'Range','A3');
    % [numRows,numCols] = size(lineNumber); % Needed if more information is read.
    % endRow = numRows+(startRow-1);        % Needed if more information is read.
    [endNodesNumber] = readvars(files.modelFile,'Sheet',modelFile.linesSheet,'Range',[startRow, 3]); % C
    model.lines = table(lineNumber,endNodesNumber);
else
    info = ['Sheet ',modelFile.linesSheet,' is missing.'];
    disp(info)
end % (if)

% Reading MATERIALS
% + Units (E, gamma)
% + Number
% + Name
% + Modulus of elasticity, E
% + Poisson's ratio, nu
% + Unit weight, gamma
% + Length temperature coefficient, alpha
% + Partial safety factor, gammaM
% + Material model
% Not read
% - Shear modulus

if sum(contains(modelSheets,modelFile.materialsSheet)) == 1 % The sheet exist
    [ETitle] = readvars(files.modelFile,'Sheet',modelFile.materialsSheet,'Range',[1 3 2 3]); % C
    [gammaTitle] = readvars(files.modelFile,'Sheet',modelFile.materialsSheet,'Range',[1 6 2 6]); % F
    model.materials.unit.E = pickUpUnit(ETitle,2);
    model.materials.unit.gamma = pickUpUnit(gammaTitle,2);
    [materialNumber, materialName, E] = readvars(files.modelFile,'Sheet',modelFile.materialsSheet,'Range','A:C');
    [numRows,numCols] = size(materialNumber);
    endRow = numRows+(startRow-1);
    [nu,gamma,alpha,gammaM,materialModel] = readvars(files.modelFile,'Sheet',modelFile.materialsSheet,'Range',[startRow, 5, endRow, 9]); % E:I
    model.materials.table = table(materialNumber,materialName,E,nu,gamma,alpha,gammaM,materialModel);
else
    info = ['Sheet ',modelFile.materialsSheet,' is missing.'];
    disp(info)
end % (if)

% Read SUPPORTS
% + Number
% + Node number
% + Displacement and rotation conditions: ux, uy, uz, phix, phiy, phiz
% Not read
% - Coordinate system
if sum(contains(modelSheets,modelFile.nodalSupportsSheet)) == 1 % The sheet exist
    [supportNumber, nodeNumber] = readvars(files.modelFile,'Sheet',modelFile.nodalSupportsSheet,'Range','A:B');
    [numRows,numCols] = size(supportNumber);
    endRow = numRows+(startRow-1);
    [ux,uy,uz,phix,phiy,phiz] = readvars(files.modelFile,'Sheet',modelFile.nodalSupportsSheet,'Range',[startRow, 5, endRow, 10]);
    model.supports = table(supportNumber,nodeNumber,ux,uy,uz,phix,phiy,phiz);
else
    disp('Sheet ',modelFile.nodalSupportsSheet,' is missing.')
end % (if)

% Reading CROSS SECTIONS
% + Units (d, e)
% + Number
% + Name (description)
% + Material number
% + Weight (h->) d (in RFEM h. Replaced to avoid confusion.)
% + Height (b->) e (in RFEM b. Replaced to avoid confusion.)
% Not read
% - Moments of inertia. This is ok if the dimensions are ok.
% - Cross-sectional areas. This is ok if the dimensions are ok.
% - Angle of the main axis
% - Rotation
if sum(contains(modelSheets,modelFile.crossSectionsSheet)) == 1 % The sheet exist
    [bTitle] = readvars(files.modelFile,'Sheet',modelFile.crossSectionsSheet,'Range',[1 12 2 12]); % L
    model.cSs.unit = pickUpUnit(bTitle,1);
    [cSNumber] = readvars(files.modelFile,'Sheet',modelFile.crossSectionsSheet,'Range','A:A');
    [numRows,numCols] = size(cSNumber);
    endRow = numRows+(startRow-1);
    [name,materialNumber] = readvars(files.modelFile,'Sheet',modelFile.crossSectionsSheet,'Range',[startRow, 2, endRow, 3]); % B:C
    [e,d] = readvars(files.modelFile,'Sheet',modelFile.crossSectionsSheet,'Range',[startRow, 12, endRow, 13]); % L:M
    model.cSs.table = table(cSNumber,name,materialNumber,d,e); % The order of d and e is reversed.
else
    info = ['Sheet ',modelFile.crossSectionsSheet,' is missing.'];
    disp(info)
end % (if)

% Reading STRUCTURAL MEMBERS
% + Number
% + Line number
% + Structure type
% - Cross-section number at the beginning and end
% Not read
% - Rotation: type and angle
% - Joint: beginning and end
% - Eccentricity
% - Splitting
% - Weight. Weight is ok if dimensions and volume weight are ok.
if sum(contains(modelSheets,modelFile.membersSheet)) == 1 % The sheet exist
    [memberNumber] = readvars(files.modelFile,'Sheet',modelFile.membersSheet,'Range','A:A');
    [numRows,numCols] = size(memberNumber);
    endRow = numRows+(startRow-1);
    [lineNumber,memberType,startCSNumber,tailCSNumber] = readvars(files.modelFile,'Sheet',modelFile.membersSheet,'Range',[startRow, 2, endRow, 5]); % B:E
    model.members = table(memberNumber,lineNumber,memberType,startCSNumber,tailCSNumber);
else
    info = ['Sheet ',modelFile.membersSheet,' is missing.'];
    disp(info)
end % (if)

% Reading LOAD CASES, all data
% + Load case
% + Name (description)
% + Presency in calculation
% + Category
% + Self-weight activity
% + Self-weight load direction factors
if sum(contains(modelSheets,modelFile.loadCasesSheet)) == 1 % The sheet exist
    [x,y,z] = readvars(files.modelFile,'Sheet',modelFile.loadCasesSheet,'Range','F:H');
    [numRows,numCols] = size(x);
    endRow = numRows+(startRow-1);
    [loadCase,loaddName,presence,category,activity] = readvars(files.modelFile,'Sheet',modelFile.loadCasesSheet,'Range',[startRow, 1, endRow, 5]); % A:E
    model.loads = table(loadCase,loaddName,presence,category,activity,x,y,z);
else
    info = ['Sheet ',modelFile.loadCasesSheet,' is missing.'];
    disp(info)
end % (if)

% Reading LOAD COMBINATIONS
% + Combination name
% + Description
% Not read
% - DS (liter?)
% - Presency in the calculation
% - LC1 ... 3, number, partial safety factor
if sum(contains(modelSheets,modelFile.loadCoSheet )) == 1 % The sheet exist
    [LC1Factor] = readvars(files.modelFile,'Sheet',modelFile.loadCoSheet ,'Range','E:E');
    [numRows,numCols] = size(LC1Factor);
    endRow = numRows+(startRow-1);
    [coName] = readvars(files.modelFile,'Sheet',modelFile.loadCoSheet ,'Range',[startRow, 1, endRow, 1]); % A
    [description] = readvars(files.modelFile,'Sheet',modelFile.loadCoSheet ,'Range',[startRow, 3, endRow, 3]); % C
    model.co = table(coName,description);
else
    info = ['Sheet ',modelFile.loadCoSheet ,' is missing.'];
    disp(info)
end % (if)

% Read LC2, STRUCTURAL LOADS
% + Unit (p)
% + Number
% + Reference
% + Member number
% + Type
% + Distribution
% + Direction
% + Magnitude (p)
% Not read
% - Parameters
% - Acting lengths
% - Comments
if sum(contains(modelSheets,modelFile.LC2Sheet)) == 1 % The sheet exist
    [pTitle] = readvars(files.modelFile,'Sheet',modelFile.LC2Sheet,'Range',[1 7 2 7]); % G
    model.loadUnit = pickUpUnit(pTitle,2);
    [number] = readvars(files.modelFile,'Sheet',modelFile.LC2Sheet,'Range','A:A');
    [numRows,numCols] = size(number); 
    endRow = numRows+(startRow-1);
    [reference,memberNumber,type,distribution,direction,value] = readvars(files.modelFile,'Sheet',modelFile.LC2Sheet,'Range',[startRow, 2, endRow, 7]); % 
    model.LC2 = table(number,reference,memberNumber,type,distribution,direction,value);
else
    info = ['Sheet ',modelFile.LC2Sheet,' is missing.'];
    disp(info)
end % (if)

% Read LC3, STRUCTURAL LOADS
% + Unit is the same as in LC2 (q)
% + Number
% + Reference
% + Member number
% + Type
% + Distribution
% + Direction
% + Magnitude (q)
% Not read
% - Parameters
% - Acting lengths
% - Comments
if sum(contains(modelSheets,modelFile.LC3Sheet)) == 1 % The sheet exist
[number] = readvars(files.modelFile,'Sheet',modelFile.LC3Sheet,'Range','A:A');
[numRows,numCols] = size(number); 
endRow = numRows+(startRow-1);
[reference,memberNumber,type,distribution,direction,value] = readvars(files.modelFile,'Sheet',modelFile.LC3Sheet,'Range',[startRow, 2, endRow, 7]); % 
model.LC3 = table(number,reference,memberNumber,type,distribution,direction,value);
else
    info = ['Sheet ',modelFile.LC3Sheet,' is missing.'];
    disp(info)
end % (if)

% Reading RESULTS
% + Description
% + Value
% + Unit
% + Comment
if sum(contains(modelSheets,modelFile.resultsSheet)) == 1 % The sheet exist
%[number] = readvars(files.modelFile,'Sheet',modelFile.LC3Sheet,'Range','A:A');
%[numRows,numCols] = size(LC1Factor);
%endRow = numRows+(startRow-1);
[description,value,unit,comment] = readvars(files.modelFile,'Sheet',modelFile.resultsSheet,'Range','B:E');
model.results = table(description,value,unit,comment);
else
    info = ['Sheet ',modelFile.resultsSheet,' is missing.'];
    disp(info)
end % (if)

% Updating model UNITS
model = updateUnits(model,modelFile,modelSheets);

% VERIFICATION
% Opens the output file
reportFileID = fopen(files.reportFile,'w');
% Tulostetaan yleistiedot
printTitle(reportFileID, files);

% Checking members
checkMember(leftColumn, model, units, reportFileID);
checkMember(rightColumn, model,units, reportFileID);
checkMember(beam, model, units, reportFileID);

% Checking supports
checkSupport(leftSupport, model, units, reportFileID);
checkSupport(rightSupport, model, units, reportFileID);

% Checking loads
checkLoad(LC1, model, units, reportFileID);
checkLoad(LC2, model, units, reportFileID);
checkLoad(LC3, model, units, reportFileID);

% Checking load combinations
checkCo(CO, model, reportFileID);

% checking results
[vg,vs,u] = calcResults(q,p,leftColumn,beam);
results.LC1.name = "LC1 - Self-weight";
results.LC2.name = "LC2 - Wind";
results.LC3.name = "LC3 - Snow";
results.LC1.value = vg;
results.LC2.value = u;
results.LC3.value = vs;
checkResults(results, model, units, reportFileID)

% Closing the output file
fclose(reportFileID);

% Print the report
info = sprintf('See report file: %s',files.reportFile);
disp(info)

% Open the report file
winopen report.txt
% winopen files.reportFile % Cannot refer to a variable.

% E N D   C H E K K E R
