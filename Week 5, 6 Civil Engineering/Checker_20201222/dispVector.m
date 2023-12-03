function [F] = dispVector(Lbo,Lco,Lb,Lc,E,G,k,Ab,Ac,Ib,Ic,...
    M_lc,M_b,M_rc,M0_lc,M0_b,M0_rc,...
    N_lc,N_b,N_rc,N0_lc,N0_b,N0_rc,...
    Q_lc,Q_b,Q_rc,Q0_lc,Q0_b,Q0_rc)
% Calculates the external force of the transition vector of
% - bending moment
% - normal force
% - shear force
% Lbo - lower limit of the integral for the beam
% Lco - lower limit of the integral for the column
% Lbo - upper limit of the integral for the beam
% Lco - upper limit of the integral for the column

% Three displacements: delta_10, delta_20 ja delta_30,
for i = 1:3
    % Bending moment
    VM(i) = diff(polyval(polyint(conv(M_lc(i,:),M0_lc)),[Lco Lc]))/(E*Ic)+... % Left column
        diff(polyval(polyint(conv(M_b(i,:),M0_b)),[Lbo Lb]))/(E*Ib)+...       % Beam
        diff(polyval(polyint(conv(M_rc(i,:),M0_rc)),[Lco Lc]))/(E*Ic);        % Right column
    % Normal force
    VN(i) = diff(polyval(polyint(conv(N_lc(i,:),N0_lc)),[Lco Lc]))/(E*Ac)+...
        diff(polyval(polyint(conv(N_b(i,:),N0_b)),[Lbo Lb]))/(E*Ab)+...
        diff(polyval(polyint(conv(N_rc(i,:),N0_rc)),[Lco Lc]))/(E*Ac);
    % Shear force
    VQ(i) = diff(polyval(polyint(conv(Q_lc(i,:),Q0_lc)),[Lco Lc]))*k/(G*Ac)+...
        diff(polyval(polyint(conv(Q_b(i,:),Q0_b)),[Lbo Lb]))*k/(G*Ab)+...
        diff(polyval(polyint(conv(Q_rc(i,:),Q0_rc)),[Lco Lc]))*k/(G*Ac);
    % Sum
    V(i)= VM(i)+VN(i)+VQ(i);
end
%VM
%VN
%VQ

% Convert the horizontal vector to a vertical vector 
% and move to the other side of the equation, changing the sign.
F = transpose(-V);

end % (function)