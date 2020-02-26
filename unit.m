classdef unit
    % unit defines properties and methods used in the creation and function
    % of any unit in LOTF
    
    properties
        location = (1:2)
        locationxy
        attack
        defense
        commandPointGen
    end
    
    methods
        function obj = unit(figure, s, z)
            % Class constructor
            %   Takes in grid coordinates s and z to set an initial
            %   location for the created unit.
            
            unitImage = uiimage(figure);
            [unitImage.Position(1), unitImage.Position(2)] = leftCornerCoords(s, z);
            unitImage.Position(3:4) = [43, 40]
            
            obj.location(1:2) = [s, z];
            obj.locationxy(1:2) = leftCornerCoords(s, z);
        end
        
        function move(s, z)
            %move(s, z)
            %   Changes a unit's location to given coordinates (s, z)
            
            obj.location(1:2) = [s, z];
        end
    end
end

