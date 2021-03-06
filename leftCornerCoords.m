function [x, y] = leftCornerCoords(s, z)
% leftCornerCoords(s, z) takes in an s and a z coordinate, and returns the
% corresponding x and y coordinates of the bottom left point in the unit
% square indicated by s and z.

    x = 13+54*(s-1) + 5; % Add 5 to position to center for units of size [x, y] = [43, 40]
    
    switch (z)
        case 1
            y = 12;
        case 2
            y = 63;
        case 3
            y = 114;
        case 4
            y = 165;
        case 5
            y = 216;
        case 6
            y = 268;
        case 7
            y = 319;
        case 8
            y = 370;
        case 9
            y = 421;
        case 10
            y = 472;
        case 11
            y = 523;
        case 12
            y = 575;
        case 13
            y = 625;
        case 14
            y = 676;
        case 15
            y = 728;
        otherwise
            y = 0;
    end
    
    % Add 5 to position to center for units of size [x, y] = [43, 40]
    y = y + 5;

end

