classdef unit
    % This class defines properties and methods used in the creation and function
    % of any unit in LOTF
    
    properties (Access = public)
        unitType
        location = (1:2) % (s,z) location of the unit
        attack
        defense
        commandPointGen
        movementRange
        unitImage matlab.ui.control.Image
    end
    
    methods
        
        function obj = unit(figure, s, z, unitType, divider)
            % Class constructor
            %   figure is the figure to place on (app.UIFigure)
            %   s and z are initial grid coordinates for the unit
            %   unitType is the type of unit (testUnit, etc.)
            %   divider is the system's appropriate divider
            
            obj.unitType = unitType;
            obj.location(1:2) = [s, z];
            obj.unitImage = uiimage(figure);
            [obj.unitImage.Position(1),obj.unitImage.Position(2)] = leftCornerCoords(obj.location(1),obj.location(2));
            obj.unitImage.Position(3:4) = [43, 40]; % Set size of unit
            
            
            
            if (strcmp(unitType, "testUnit"))
                obj.unitImage.ImageSource = "images" + divider + "units" + divider + "testUnit.png";
                obj.attack = 1;
                obj.defense = 1;
                obj.commandPointGen = 1;
                obj.movementRange = 2;
            end
            
            if(strcmp(unitType, "testUnit2"))
                obj.unitImage.ImageSource = "images" + divider + "units" + divider + "testUnit2.png";
                obj.attack = 1;
                obj.defense = 1;
                obj.commandPointGen = 1;
                obj.movementRange = 2;
            end
        end
        
    end
    
    
        
    
    methods (Static, Access = public)
        function updateLocation(loc)
            disp(loc);
            [obj.unitImage.Position(1), obj.unitImage.Position(2)] = leftCornerCoords(loc(1),loc(2));
            
        end
    end
end

