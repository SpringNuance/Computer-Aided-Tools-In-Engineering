function A = area(shape,b,h)
% Calculates the area of a rectangle.
switch shape
    case 'Rectangle'
        A = b*h;
    otherwise
        A = 0;
        disp('Use rectangle cross-section!')
end % (switch)
end % (function)