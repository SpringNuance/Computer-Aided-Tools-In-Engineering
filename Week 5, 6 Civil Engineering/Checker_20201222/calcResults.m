function [vg,vs,u] = calcResults(q,p,column,beam)
% Calculates the results of wind (p) and snow load (q) using the unit force method.
% The calculation takes into account the effects of bending moment, normal and
% shear force on displacement variables (delta_ij).

% Cross-sectional values
Lb = beam.L;
Ab = beam.cS.A;
Ib = beam.cS.Iz;
k = beam.cS.k;
E = beam.material.E;
G = beam.material.G;
%nu = beam.material.nu;
%gamma = beam.material.gamma;
Lc = column.L;
Ac = column.cS.A;
Ic = column.cS.Iz;
% Self-weight
gb = beam.g;
gc = column.g;

% Bending moments due to unit forces (X_M = X_N = X_Q = 1)
M1_lc = [0 1 0];    % y
M1_b= [0 0 Lc];     % Lc
M1_rc = [0 1 0];    % y
M2_lc = [0 0 Lb];   % Lb
M2_b = [0 -1 Lb];   % Lb-x
M2_rc = [0 0 0]; 
M3_lc = [0 0 1];
M3_b = [0 0 1];
M3_rc = [0 0 1];
% Bending moments, vector form
M_lc = [M1_lc; M2_lc; M3_lc];   % Left column
M_b = [M1_b; M2_b; M3_b];       % Beam
M_rc = [M1_rc; M2_rc; M3_rc];   % Right column
% Shear forces due to unit forces
Q1_lc = [0 0 1];    
Q1_b= [0 0 0];     
Q1_rc = [0 0 -1];    
Q2_lc = [0 0 0];   
Q2_b = [0 0 -1];   
Q2_rc = [0 0 0]; 
Q3_lc = [0 0 0];
Q3_b = [0 0 0];
Q3_rc = [0 0 0];
% Shear forces, vector form
Q_lc = [Q1_lc; Q2_lc; Q3_lc];
Q_b = [Q1_b; Q2_b; Q3_b];
Q_rc = [Q1_rc; Q2_rc; Q3_rc];
% Normal forces due to unit forces
N1_lc = [0 0 0];    
N1_b= [0 0 1];     
N1_rc = [0 0 0];    
N2_lc = [0 0 1];   
N2_b = [0 0 0];   
N2_rc = [0 0 -1]; 
N3_lc = [0 0 0];
N3_b = [0 0 0];
N3_rc = [0 0 0];
% Normal forces, vector force
N_lc = [N1_lc; N2_lc; N3_lc];
N_b = [N1_b; N2_b; N3_b];
N_rc = [N1_rc; N2_rc; N3_rc];
% Coefficient matrix, 3x3, due to bending momen, normal and shear force
for i = 1:3
     for j = 1:3
        KM(i,j) = diff(polyval(polyint(conv(M_lc(i,:),M_lc(j,:))),[0 Lc]))/(E*Ic)+...
            diff(polyval(polyint(conv(M_b(i,:),M_b(j,:))),[0 Lb]))/(E*Ib)+...
            diff(polyval(polyint(conv(M_rc(i,:),M_rc(j,:))),[0 Lc]))/(E*Ic);
        KN(i,j) = diff(polyval(polyint(conv(N_lc(i,:),N_lc(j,:))),[0 Lc]))/(E*Ac)+...
            diff(polyval(polyint(conv(N_b(i,:),N_b(j,:))),[0 Lb]))/(E*Ab)+...
            diff(polyval(polyint(conv(N_rc(i,:),N_rc(j,:))),[0 Lc]))/(E*Ac);
        KQ(i,j) = diff(polyval(polyint(conv(Q_lc(i,:),Q_lc(j,:))),[0 Lc]))*k/(G*Ac)+...
            diff(polyval(polyint(conv(Q_b(i,:),Q_b(j,:))),[0 Lb]))*k/(G*Ab)+...
            diff(polyval(polyint(conv(Q_rc(i,:),Q_rc(j,:))),[0 Lc]))*k/(G*Ac);
        K(i,j)= KM(i,j)+KN(i,j)+KQ(i,j);
     end
end

% SELF-WEIGHT
% Bending moments
M0g_lc = [0 0 -gb*Lb^2/2-gc*Lb*Lc]; % -gb*Lb^2/2 -gc*Lb*Lc
M0g_b = [-gb/2 gb*Lb-gc*Lc -gb*Lb^2/2];   % -gb*x^2/2 + gb*Lb*x -gb*Lb^2/2 -gc*Lc*x
M0g_rc = [0 0 0];
% Shear forces
Q0g_lc = [0 0 0];
Q0g_b = [0 -gb gb*Lb]; % -gb*x+gb*Lb-gc*Lc
Q0g_rc = [0 0 0];
% Normal forces
N0g_lc = [0 0 -gb*Lb-gc*Lc];   % -gb*Lb -gc*Lc. The self-weight of the left column in not taken account.
N0g_b = [0 0 0];   
N0g_rc = [0 0 0];
% Deflection at the mid span
vg = calcVertLC(0,0,Lb,Lc,E,G,k,Ab,Ac,Ib,Ic,...
    M_lc,M_b,M_rc,M0g_lc,M0g_b,M0g_rc,...
    N_lc,N_b,N_rc,N0g_lc,N0g_b,N0g_rc,...
    Q_lc,Q_b,Q_rc,Q0g_lc,Q0g_b,Q0g_rc,K);

% SNOW LOAD ON THE BEAM
% Bending moments
M0s_lc = [0 0 -q*Lb^2/2];        % -q*Lb^2/2
M0s_b = [-q/2 q*Lb -q*Lb^2/2];   % -q*x^2/2 + q*Lb*x -q*Lb^2/2
M0s_rc = [0 0 0];
% Shear forces
Q0s_lc = [0 0 0];
Q0s_b = [0 -q q*Lb]; % -q*x+q*Lb   
Q0s_rc = [0 0 0];
% Normal forces
N0s_lc = [0 0 -q*Lb];   % -q*Lb
N0s_b = [0 0 0];   
N0s_rc = [0 0 0];
% Deflection in the mid span
vs = calcVertLC(0,0,Lb,Lc,E,G,k,Ab,Ac,Ib,Ic,...
    M_lc,M_b,M_rc,M0s_lc,M0s_b,M0s_rc,...
    N_lc,N_b,N_rc,N0s_lc,N0s_b,N0s_rc,...
    Q_lc,Q_b,Q_rc,Q0s_lc,Q0s_b,Q0s_rc,K);

% WIND LOAD ON THE LEFT COLUMN
% Bending moment due to wind load
M0w_lc = [-p/2 p*Lc -p*Lc^2/2]; % -p/2*y^2+p*Lc*y-p*Lcb^2/2
M0w_b = [0 0 0];
M0w_rc = [0 0 0];
% Shear force due to wind load
Q0w_lc = [0 -p p*Lc];   % p(Lc-y)
Q0w_b = [0 0 0];  
Q0w_rc = [0 0 0];
% Normal force due to wind load
N0w_lc = [0 0 -0];
N0w_b = [0 0 0];   
N0w_rc = [0 0 0];
% Displacement vector due to wind load (bending moment, shear and normal force)
Fw = dispVector(0,0,Lb,Lc,E,G,k,Ab,Ac,Ib,Ic,...
    M_lc,M_b,M_rc,M0w_lc,M0w_b,M0w_rc,...
    N_lc,N_b,N_rc,N0w_lc,N0w_b,N0w_rc,...
    Q_lc,Q_b,Q_rc,Q0w_lc,Q0w_b,Q0w_rc);
% Force vector due to wind load (bending moment, shear and normal force)
Xw = inv(K)*Fw;
% Bending moments of the frame due to wind load (Could be calculated also as a vector [XM; XN; XQ])
Mw_lc = M0w_lc + Xw(1)*M1_lc + Xw(2)*M2_lc + Xw(3)*M3_lc;
Mw_b = M0w_b + Xw(1)*M1_b + Xw(2)*M2_b + Xw(3)*M3_b;
Mw_rc = M0w_rc + Xw(1)*M1_rc + Xw(2)*M2_rc + Xw(3)*M3_rc;
% Shear foces of the frame due to wind load
Qw_lc = Q0w_lc + Xw(1)*Q1_lc + Xw(2)*Q2_lc + Xw(3)*Q3_lc;
Qw_b = Q0w_b + Xw(1)*Q1_b + Xw(2)*Q2_b + Xw(3)*Q3_b;
Qw_rc = Q0w_rc + Xw(1)*Q1_rc + Xw(2)*Q2_rc + Xw(3)*Q3_rc;
% Normal forecs of the framde due to wind load
Nw_lc = N0w_lc + Xw(1)*N1_lc + Xw(2)*N2_lc + Xw(3)*N3_lc;
Nw_b = N0w_b + Xw(1)*N1_b + Xw(2)*N2_b + Xw(3)*N3_b;
Nw_rc = N0w_rc + Xw(1)*N1_rc + Xw(2)*N2_rc + Xw(3)*N3_rc;

% TOP DEFLECTION OF THE COLUMN DUE TO WIND LOAD
% Bending moment due to unit force acting at the top of the column
M0u_lc = [0 1 -Lc];   % y-Lc
M0u_b = [0 0 0];
M0u_rc = [0 0 0];
% Shear force due to unit force acting at the top of the column
Q0u_lc = [0 0 1];
Q0u_b = [0 0 0];
Q0u_rc = [0 0 0];
% Normal force due to unit force acting at the top of the column
N0u_lc = [0 0 0];
N0u_b = [0 0 0];
N0u_rc = [0 0 0];
% Displacement vector due to unit force acting at the top of the column
Fu = dispVector(0,0,Lb,Lc,E,G,k,Ab,Ac,Ib,Ic,...
    M_lc,M_b,M_rc,M0u_lc,M0u_b,M0u_rc,...
    N_lc,N_b,N_rc,N0u_lc,N0u_b,N0u_rc,...
    Q_lc,Q_b,Q_rc,Q0u_lc,Q0u_b,Q0u_rc);
% Force vector due to unit force acting at the top of the column
Xu = inv(K)*Fu;
% Bending moment of the frame due to unit force acting at the top of the column
Mu_lc = M0u_lc + Xu(1)*M1_lc + Xu(2)*M2_lc + Xu(3)*M3_lc;
Mu_b = M0u_b + Xu(1)*M1_b + Xu(2)*M2_b + Xu(3)*M3_b;
Mu_rc = M0u_rc + Xu(1)*M1_rc + Xu(2)*M2_rc + Xu(3)*M3_rc;
% Shear force of the frame due to unit force acting at the top of the column
Qu_lc = Q0u_lc + Xu(1)*Q1_lc + Xu(2)*Q2_lc + Xu(3)*Q3_lc;
Qu_b = Q0u_b + Xu(1)*Q1_b + Xu(2)*Q2_b + Xu(3)*Q3_b;
Qu_rc = Q0u_rc + Xu(1)*Q1_rc + Xu(2)*Q2_rc + Xu(3)*Q3_rc;
% Normal force of the frame due to unit force acting at the top of the column
Nu_lc = N0u_lc + Xu(1)*N1_lc + Xu(2)*N2_lc + Xu(3)*N3_lc;
Nu_b = N0u_b + Xu(1)*N1_b + Xu(2)*N2_b + Xu(3)*N3_b;
Nu_rc = N0u_rc + Xu(1)*N1_rc + Xu(2)*N2_rc + Xu(3)*N3_rc;
% Top deflection of column due to wind
uM =    diff(polyval(polyint(conv(Mw_lc,Mu_lc)),[0 Lc]))/(E*Ic)+...
        diff(polyval(polyint(conv(Mw_b,Mu_b)),[0 Lb]))/(E*Ib)+...
        diff(polyval(polyint(conv(Mw_rc,Mu_rc)),[0 Lc]))/(E*Ic);
uQ =    diff(polyval(polyint(conv(Qw_lc,Qu_lc)),[0 Lc]))*k/(G*Ac)+...
        diff(polyval(polyint(conv(Qw_b,Qu_b)),[0 Lb]))*k/(G*Ab)+...
        diff(polyval(polyint(conv(Qw_rc,Qu_rc)),[0 Lc]))*k/(G*Ac);
uN =    diff(polyval(polyint(conv(Nw_lc,Nu_lc)),[0 Lc]))/(E*Ac)+...
        diff(polyval(polyint(conv(Nw_b,Nu_b)),[0 Lb]))/(E*Ab)+...
        diff(polyval(polyint(conv(Nw_rc,Nu_rc)),[0 Lc]))/(E*Ac);
u = uM + uQ + uN;

end % (function)