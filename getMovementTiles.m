function [sVals,zVals] = getMovementTiles(movement,s,z)
%getMovementTiles(movement,s,z) takes in a unit's movement range movement,
%and the location of the unit (s,z), and returns an array of points,
%corresponding to movement indicators to highlight.

j = 0;
for i = 1:movement
    
    sVals(1+4*j) = s+i;
    zVals(1+4*j) = z;
    
    sVals(2+4*j) = s;
    zVals(2+4*j) = z+i;
    
    sVals(3+4*j) = s-i;
    zVals(3+4*j) = z;
    
    sVals(4+4*j) = s;
    zVals(4+4*j) = z - i;
    
    j = j+1;  
end

for i = 1:movement-1
    
    sVals = [sVals, s+i];
    zVals = [zVals, z+i];
    
    sVals = [sVals, s-i];
    zVals = [zVals, z+i];
    
    sVals = [sVals, s-i];
    zVals = [zVals, z-i];
    
    sVals = [sVals, s+i];
    zVals = [zVals, z-i];
    
    
end

end

