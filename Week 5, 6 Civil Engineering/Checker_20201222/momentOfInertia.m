function I = momentOfInertia(shape,b,h)
% Calculates moment of inertia of rectangle cross-section.
switch shape
    case 'Rectangle'
        I = b*h^3/12;
    otherwise
        I = 0;
        disp('Use rectangle cross-section!')
end % (switch)
end % (function)