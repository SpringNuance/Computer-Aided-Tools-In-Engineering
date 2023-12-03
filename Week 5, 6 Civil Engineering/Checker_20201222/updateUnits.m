function model = updateUnits(model,modelFile,modelSheets)
% Checking and updating the units

% Nodepoints x, y
switch model.nodeCo.unit
    case 'm'
        model.nodeCo.table.x = model.nodeCo.table.x;
        model.nodeCo.table.y = model.nodeCo.table.y;
        % disp('m')
    case 'cm'
        model.nodeCo.table.x = model.nodeCo.table.x/100;
        model.nodeCo.table.y = model.nodeCo.table.y/100;
        model.nodeCo.unit = 'm';
        % disp('cm')
    case 'mm'
        model.nodeCo.table.x = model.nodeCo.table.x/1000;
        model.nodeCo.table.y = model.nodeCo.table.y/1000;
        model.nodeCo.unit = 'm';
        % disp('mm')
    otherwise
        disp('Use SI-units!')
end % (switch)

% Width d and height e of the cross-section
switch model.cSs.unit
    case 'm'
        model.cSs.table.d = model.cSs.table.d;
        model.cSs.table.e = model.cSs.table.e;
        % disp('m')
    case 'cm'
        model.cSs.table.d = model.cSs.table.d/100;
        model.cSs.table.e = model.cSs.table.e/100;
        model.cSs.unit = 'm';
        % disp('cm')
    case 'mm'
        model.cSs.table.d = model.cSs.table.d/1000;
        model.cSs.table.e = model.cSs.table.e/1000;
       model.cSs.unit = 'm';
        % disp('mm')
    otherwise
        disp('Use SI-units!')
end % (switch)

% Material constant: modulus of elasticity E
switch model.materials.unit.E
    case {'MN/m2', 'N/mm2', 'MPa'}
        model.materials.table.E = model.materials.table.E;
    case 'kN/cm2'
        model.materials.table.E = model.materials.table.E*10;
        model.materials.unit.E = 'MN/m2';
    case {'kN/m2', 'kPa'}
        model.materials.table.E = model.materials.table.E/1000;
        model.materials.unit.E = 'MN/m2';      
    case {'N/m2', 'Pa'}
        model.materials.table.E = model.materials.table.E/10^6;
        model.materials.unit.E = 'MN/m2';
    case 'GPa'
        model.materials.table.E = model.materials.table.E*1000;
        model.materials.unit.E = 'MN/m2';
    case 'bar'
        model.materials.table.E = model.materials.table.E/10;
        model.materials.unit.E = 'MN/m2';
    otherwise
        disp('Use SI-units!')
end % (switch)

% Material constant: unit weight, gamma
switch model.materials.unit.gamma
    case 'kN/m3'
        model.materials.table.gamma = model.materials.table.gamma;
    case 'MN/m3'
        model.materials.table.gamma = model.materials.table.gamma*1000;
        model.materials.unit.gamma = 'kN/m3';
    case 'N/m3'
        model.materials.table.gamma = model.materials.table.gamma/1000;
        model.materials.unit.gamma = 'kN/m3';      
    case {'kN/cm3', 'N/mm3'}
        model.materials.table.gamma = model.materials.table.gamma*10^6;
        model.materials.unit.gamma = 'kN/m3';
    otherwise
        disp('Use SI-units!')
end % (switch)

% Distributed load: q, p
if sum(contains(modelSheets,modelFile.LC2Sheet)) == 1 &...
        sum(contains(modelSheets,modelFile.LC3Sheet)) == 1 % Sheets exists.
    switch model.loadUnit
        case {'kN/m', 'N/mm'}
            model.LC2.value = model.LC2.value;
            model.LC3.value = model.LC3.value;
        case 'N/m'
            model.LC2.value = model.LC2.value/1000;
            model.LC3.value = model.LC3.value/1000;
            model.LC2.unit = 'kN/m';
        case {'MN/m', 'kN/mm'}
            model.LC2.value = model.LC2.value*1000;
            model.LC3.value = model.LC3.value*1000;
            model.LC2.unit = 'kN/m';      
        case 'kN/cm'
            model.LC2.value = model.LC2.value*100;
            model.LC3.value = model.LC3.value*100;
            model.LC2.unit = 'kN/m';
        case 'N/cm'
            model.LC2.value = model.LC2.value/10;
            model.LC3.value = model.LC3.value/10;
            model.LC2.unit = 'kN/m';
        case 'MN/cm'
            model.LC2.value = model.LC2.value*10^5;
            model.LC3.value = model.LC3.value*10^5;
            model.LC2.unit = 'kN/m';
        case 'MN/mm'
            model.LC2.value = model.LC2.value*10^6;
            model.LC3.value = model.LC3.value*10^6;
            model.LC2.unit = 'kN/m';      
        otherwise
            disp('Use SI-units!')
    end % (switch)   
end % (if)

end % (function)