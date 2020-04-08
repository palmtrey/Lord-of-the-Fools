classdef unit
    % This class defines properties and methods used in the creation and function
    % of any unit in LOTF
    
    properties (Access = public)
        location = (1:2)
        attack
        defense
        commandPointGen
        unitImage matlab.ui.control.Image
    end
    
    methods
        
        function obj = unit(figure, s, z, unitType)
            % Class constructor
            %   figure is the figure to place on (app.UIFigure)
            %   s and z are initial grid coordinates for the unit
            %   unitType is the type of unit (testUnit, etc.)
            
            obj.location(1:2) = [s, z];
            unitImage = uiimage(figure);
            obj.updateLocation();
            unitImage.Position(3:4) = [43, 40]; % Set size of unit
            
            
            
            if (strcmp(unitType, 'testUnit'))
                unitImage.ImageSource = 'images/units/testUnit.png';
                obj.attack = 1;
                obj.defense = 1;
                obj.commandPointGen = 1;
            end
        end
        
        function move(s, z)
            % move(s, z) Changes a unit's location to given coordinates (s, z)
            
            obj.location(1:2) = [s, z];
            updateLocation();
        end
        
    end
    
    
        
    
    methods (Static, Access = public)
        function updateLocation()
            [unitImage.Position(1), unitImage.Position(2)] = obj.location(1:2);
        end
    end
end

