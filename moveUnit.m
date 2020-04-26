function [tileOccupied, existingUnits] = moveUnit(unit,s,z,tileOccupied,existingUnits)
%moveUnit(unit,s,z) moves a unit to the coordinates (s,z)
   
    if validateCoords(s,z)
        % Set the unit's image location to the new (s,z) coordinates
        [existingUnits(unit.unitId).unitImage.Position(1), existingUnits(unit.unitId).unitImage.Position(2)] = leftCornerCoords(s,z);
        
        % Set the old tile as unoccupied
        tileOccupied(existingUnits(unit.unitId).location(1),existingUnits(unit.unitId).location(2)) = false;
        
        % Set the new location for the unit
        existingUnits(unit.unitId).location(1) = s;
        existingUnits(unit.unitId).location(2) = z;
        
        % Set the new tile as occupied
        tileOccupied(s,z) = true;
        
    end
end

