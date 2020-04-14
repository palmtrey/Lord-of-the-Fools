function [good] = validateCoords(s,z)
%validateCoords(s,z) takes in coordinates in the sz plane (ranging from
%1:15) and checks if they are within 1:15

    if inRange(s, 15, 14) && inRange(z, 15, 14)
        good = true;
    else
        good = false;
    end

end

