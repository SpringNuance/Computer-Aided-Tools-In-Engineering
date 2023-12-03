function k = shapeFactor(shape)
% Calculates the area of a rectangle.

switch shape
    case 'Rectangle'
        k = 1.2;
    otherwise
        k = 0;
        disp('Use rectangle cross-section!')
end % (switch)

end % (function)