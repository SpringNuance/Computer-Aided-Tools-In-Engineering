function [v] = calcVertLC(Lbo,Lco,Lb,Lc,E,G,k,Ab,Ac,Ib,Ic,...
    M_lc,M_b,M_rc,M0s_lc,M0s_b,M0s_rc,...
    N_lc,N_b,N_rc,N0s_lc,N0s_b,N0s_rc,...
    Q_lc,Q_b,Q_rc,Q0s_lc,Q0s_b,Q0s_rc,K)
% Calculates the vertical load case using the unit force method.
% The calculation takes into account the effects of bending moment, normal and
% shear force on displacement variables (delta_ij).

% Dispalcement vector due to vertical load (bending moment, shear and
% normal force)
Fs = dispVector(Lbo,Lco,Lb,Lc,E,G,k,Ab,Ac,Ib,Ic,...
    M_lc,M_b,M_rc,M0s_lc,M0s_b,M0s_rc,...
    N_lc,N_b,N_rc,N0s_lc,N0s_b,N0s_rc,...
    Q_lc,Q_b,Q_rc,Q0s_lc,Q0s_b,Q0s_rc);
% Force vector due to vertical load (bending momnet, shear and
% normal force)
Xs = inv(K)*Fs;
% Bending moment of the frame due to vertical load (also possible to
% calcualte as a vector [XM; XN; XQ])
Ms_lc = M0s_lc + Xs(1)*M_lc(1,:) + Xs(2)*M_lc(2,:) + Xs(3)*M_lc(3,:);
Ms_b = M0s_b + Xs(1)*M_b(1,:) + Xs(2)*M_b(2,:) + Xs(3)*M_b(3,:);
Ms_rc = M0s_rc + Xs(1)*M_rc(1,:) + Xs(2)*M_rc(2,:) + Xs(3)*M_rc(3,:);
% Shear force of the frame due to vertical load
Qs_lc = Q0s_lc + Xs(1)*Q_lc(1,:) + Xs(2)*Q_lc(2,:) + Xs(3)*Q_lc(3,:);
Qs_b = Q0s_b + Xs(1)*Q_b(1,:) + Xs(2)*Q_b(2,:) + Xs(3)*Q_b(3,:);
Qs_rc = Q0s_rc + Xs(1)*Q_rc(1,:) + Xs(2)*Q_rc(2,:) + Xs(3)*Q_rc(3,:);
% Normal force of the frame due to vertical load
Ns_lc = N0s_lc + Xs(1)*N_lc(1,:) + Xs(2)*N_lc(2,:) + Xs(3)*N_lc(3,:);
Ns_b = N0s_b + Xs(1)*N_b(1,:) + Xs(2)*N_b(2,:) + Xs(3)*N_b(3,:);
Ns_rc = N0s_rc + Xs(1)*N_rc(1,:) + Xs(2)*N_rc(2,:) + Xs(3)*N_rc(3,:);

% DEFLECTION OF THE MID OF THE BEAM DUE TO VERTICAL LOAD
% Bending moment due to unit load acting at mid of the beam
M0v_lc = [0 0 -Lb/2];   % -Lb/2
M0va_b = [0 1 -Lb/2];   % x-Lb/2. NB! valid between x = [0, Lb/2]
M0vb_b = [0 0 0];       % NB! valid between x = [Lb/2, Lb]
M0v_rc = [0 0 0];
% Shear force due to unit load acting at mid of the beam
Q0v_lc = [0 0 0];
Q0va_b = [0 0 1];    % NB! valid between x = [0, Lb/2]
Q0vb_b = [0 0 0];    % NB! valid between x = [Lb/2, Lb]
Q0v_rc = [0 0 0];
% Normal force due to unit load acting at mid of the beam
N0v_lc = [0 0 -1];
N0v_b = [0 0 0];
N0v_rc = [0 0 0];

% Displacement vector due to point load acting at mid of the beam
% Integrated in between x = [0 Lb/2], y = [0 Lc/2]
Fva = dispVector(0,0,Lb/2,Lc/2,E,G,k,Ab,Ac,Ib,Ic,...
    M_lc,M_b,M_rc,M0v_lc,M0va_b,M0v_rc,...
    N_lc,N_b,N_rc,N0v_lc,N0v_b,N0v_rc,...
    Q_lc,Q_b,Q_rc,Q0v_lc,Q0va_b,Q0v_rc);
% Integrated in between x = [Lb/2 Lb], y = [Lc/2 Lc]
Fvb = dispVector(Lb/2,Lc/2,Lb,Lc,E,G,k,Ab,Ac,Ib,Ic,...
    M_lc,M_b,M_rc,M0v_lc,M0vb_b,M0v_rc,...
    N_lc,N_b,N_rc,N0v_lc,N0v_b,N0v_rc,...
    Q_lc,Q_b,Q_rc,Q0v_lc,Q0vb_b,Q0v_rc);
Fv = Fva + Fvb;
% Force vector due to point load acting at mid of the beam
Xv = inv(K)*Fv;
% Bending moment of the frame due to point load acting at mid of the beam
Mv_lc = M0v_lc + Xv(1)*M_lc(1,:) + Xv(2)*M_lc(2,:) + Xv(3)*M_lc(3,:);
Mva_b = M0va_b + Xv(1)*M_b(1,:) + Xv(2)*M_b(2,:) + Xv(3)*M_b(3,:);  % Valid when x=[0,Lb/2]
Mvb_b = M0vb_b + Xv(1)*M_b(1,:) + Xv(2)*M_b(2,:) + Xv(3)*M_b(3,:);  % Valid when x=[Lb/2,Lb]
Mv_rc = M0v_rc + Xv(1)*M_rc(1,:) + Xv(2)*M_rc(2,:) + Xv(3)*M_rc(3,:);
% Shear force of the frame due to point load acting at mid of the beam
Qv_lc = Q0v_lc + Xv(1)*Q_lc(1,:) + Xv(2)*Q_lc(2,:) + Xv(3)*Q_lc(3,:);
Qva_b = Q0va_b + Xv(1)*Q_b(1,:) + Xv(2)*Q_b(2,:) + Xv(3)*Q_b(3,:);  % Valid when x=[0,Lb/2]
Qvb_b = Q0vb_b + Xv(1)*Q_b(1,:) + Xv(2)*Q_b(2,:) + Xv(3)*Q_b(3,:);  % Valid when x=[Lb/2,Lb]
Qv_rc = Q0v_rc + Xv(1)*Q_rc(1,:) + Xv(2)*Q_rc(2,:) + Xv(3)*Q_rc(3,:);
% Normal force of the frame due to point load acting at mid of the beam
Nv_lc = N0v_lc + Xv(1)*N_lc(1,:) + Xv(2)*N_lc(2,:) + Xv(3)*N_lc(3,:);
Nv_b = N0v_b + Xv(1)*N_b(1,:) + Xv(2)*N_b(2,:) + Xv(3)*N_b(3,:);
Nv_rc = N0v_rc + Xv(1)*N_rc(1,:) + Xv(2)*N_rc(2,:) + Xv(3)*N_rc(3,:);
% Deflection at mid of the beam
vM =    diff(polyval(polyint(conv(Ms_lc,Mv_lc)),[0 Lc]))/(E*Ic)+...
        diff(polyval(polyint(conv(Ms_b,Mva_b)),[0 Lb/2]))/(E*Ib)+...
        diff(polyval(polyint(conv(Ms_b,Mvb_b)),[Lb/2 Lb]))/(E*Ib)+...
        diff(polyval(polyint(conv(Ms_rc,Mv_rc)),[0 Lc]))/(E*Ic);
vQ =    diff(polyval(polyint(conv(Qs_lc,Qv_lc)),[0 Lc]))*k/(G*Ac)+...
        diff(polyval(polyint(conv(Qs_b,Qva_b)),[0 Lb/2]))*k/(G*Ab)+...
        diff(polyval(polyint(conv(Qs_b,Qvb_b)),[Lb/2 Lb]))*k/(G*Ab)+...
        diff(polyval(polyint(conv(Qs_rc,Qv_rc)),[0 Lc]))*k/(G*Ac);
vN =    diff(polyval(polyint(conv(Ns_lc,Nv_lc)),[0 Lc]))/(E*Ac)+...
        diff(polyval(polyint(conv(Ns_b,Nv_b)),[0 Lb]))/(E*Ab)+...
        diff(polyval(polyint(conv(Ns_rc,Nv_rc)),[0 Lc]))/(E*Ac);
v = vM + vQ + vN;
end % (function)