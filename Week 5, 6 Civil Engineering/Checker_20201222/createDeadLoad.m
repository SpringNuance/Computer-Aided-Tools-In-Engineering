function load = createDeadLoad(loadCase, name, category, presence, activity,...
    dirFactors)

% Defines the load

% Organize the data in structural table form
load.case = loadCase;               % Load case
load.name = name;                   % Load name
load.category = category;           % Load category
load.presence = presence;           % Presence in calculation
load.activity = activity;           % Activity (+ only for self-weight)
load.dirFactors = dirFactors;       % Load direction factor [x y z]

end % (function)