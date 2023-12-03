function W= mass(A,L,gamma)
% Laskee omanpainon vakiopoikkileikkauksen tapauksessa
% Calculates the self-weight in the case of a unchangeable cross section
global g;
k = 1000;    % Changing: kN/(m/s^2) -> k*kg = 1000 kg
W = k*A*L*gamma/g;
end % (function)