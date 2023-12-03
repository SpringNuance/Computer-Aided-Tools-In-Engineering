function load = createLoad(loadCase, name, category, presence, activity,...
    reference, type, distribution, direction, p, nodeMatrix)

% Defines the load

% Organize the data structure in table form
load.case = loadCase;               % Load case
load.name = name;                   % Load name
load.category = category;           % Load category
load.presence = presence;           % Presence in calculation
load.activity = activity;           % Activity (+ only for self-weight)
load.reference = reference;         % Load reference
load.type = type;                   % Load type F/M
load.distribution = distribution;   % Load distribution
load.direction = direction;         % Load direction
load.value = p;                     % Load value
load.nodeMatrix = nodeMatrix;       % Acting point: coordinate values [x1 y1; x2 y2]

end % (function)

