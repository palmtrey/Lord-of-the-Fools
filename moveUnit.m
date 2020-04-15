function moveUnit(unit,s,z)
%moveUnit(unit,s,z) moves a unit to the coordinates (s,z)
   
    if validateCoords(s,z)
        [unit.unitImage.Position(1), unit.unitImage.Position(2)] = leftCornerCoords(s,z);
    end
end

