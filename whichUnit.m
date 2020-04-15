function theUnit = whichUnit(existingUnits,s,z)
%whichUnit(existingUnits, s, z) takes in a list of existing units, and the
%coordinates at which there is a unit, and returns which unit in
%existingUnits is at (s,z)

for i = 1:length(existingUnits)
    if existingUnits(i).location(1) == s && existingUnits(i).location(2) == z
        theUnit = existingUnits(i)
    else
        theUnit = null;
    end
end

end

