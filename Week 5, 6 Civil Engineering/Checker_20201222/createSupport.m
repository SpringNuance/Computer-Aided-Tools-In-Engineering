function support = createSupport(name, bCs, coVector)
% Defines support

% Organize the data structure in tabular form
support.name = name;            % Name
support.bCs.ux = bCs(1);        % bCs = Boundary conditions [ux,uy,uz,phix,phiy,phiz]
support.bCs.uy = bCs(2);
support.bCs.uz = bCs(3);
support.bCs.phix = bCs(4);
support.bCs.phiy = bCs(5);
support.bCs.phiz = bCs(6);
support.coVector = coVector;    % Coordinate vector [x1 y1]

end % (function)