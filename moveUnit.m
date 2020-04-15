function [tileOccupied, existingUnits] = moveUnit(unit,s,z,tileOccupied,existingUnits)
%moveUnit(unit,s,z) moves a unit to the coordinates (s,z)
   
    if validateCoords(s,z)
        [unit.unitImage.Position(1), unit.unitImage.Position(2)] = leftCornerCoords(s,z);
        tileOccupied(existingUnits(1).location(1),existingUnits(1).location(2)) = false;
        existingUnits(1).location(1) = s;
        existingUnits(1).location(2) = z;
        tileOccupied(s,z) = true;
        
    end
end

