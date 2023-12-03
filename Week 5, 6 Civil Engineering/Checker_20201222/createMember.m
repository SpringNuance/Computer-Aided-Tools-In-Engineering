function member = createMember(name, class, type, nodeCoMatrix, L,...
    cSShape, d, e, material, E, nu, gamma, gammaM, materialModel)
% Define member
% Use functions:
% * area.m
% * momentOfInertia.m
% * mass.m
% * shapeFactor.m
% * shearModulus.m

% Organize the data in structural table form
member.name = name;                             % Member name
member.class = class;                           % Member class
member.type = type;                             % Member type
member.nodeCoMatrix = nodeCoMatrix;             % Coordinate matrix [x1 y1; x2 y2]
member.L = L;                                   % Length
member.cS.shape = cSShape;                      % Shape of the cross-section
member.cS.d = d;                                % Width of the cross-section
member.cS.e = e;                                % Height of the cross-section
member.material.name = material;                % Material name
member.material.E = E;                          % Modulus of elasticity
member.material.nu = nu;                        % Poisson's ratio
member.material.gamma = gamma;                  % Unit weight
member.material.gammaM = gammaM;                % Safety factor of the material
member.material.materialModel = materialModel;  % Material model

% Calculate the shear modulus
member.material.G = shearModulus(E,nu);         % G
% Calculate the cross-section quantities
A = area(cSShape,d,e);                          % Area
member.cS.A = A;
member.cS.Iz = momentOfInertia(cSShape,d,e);    % Iz
member.cS.k = shapeFactor(cSShape);             % k
% Calculate self weight as a lineload
member.g = A*gamma;                             % g
% Calculate mass
member.mass = mass(A,L,gamma);                  % W

end % (function)