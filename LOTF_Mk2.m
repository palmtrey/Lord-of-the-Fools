% Title: Lord of the Fools
%
% Purpose: To create a strategy game resembling the Gameboy Advance SP Lord
% of the Rings The Third Age video game
%
% Developers: Cameron Palmer and Henry Haggart
%
% Last Modified: Tuesday, April 14, 2020 by Cameron Palmer
%
%
% Notes:
% - Image location and size is defined by [x-coordrelui, y-coordrelui, width, height]
% - Wherever a "divider" variable is mentioned, this is simply either a
%   forward or back slash, depending on the system (Windows or Mac) so that
%   files can load correctly


classdef LOTF_Mk2 < matlab.apps.AppBase
    
    % Properties that correspond to app components
    properties (Access = public)
        
        UIFigure matlab.ui.Figure
        Grid matlab.ui.control.Image
        Overlay matlab.ui.control.Image
        testUnit                         % A test unit
        testUnit2
        divider                          % System-specific. Takes the val '\' if on Windows, '/' if on Mac.
        tileOccupied = [15,15]           % A bool array that keeps track of occupied tiles
        movementIndicators               % Blue movement icons
        existingUnits unit               % An array of existing units
        targetedUnit unit                % The currently targeted unit
    end
    
    % Callbacks that handle component events
    methods (Access = private)
        
        % Callback function for the grid image
        function overlayClicked(app, event)
            
            % Find where the pointer is relative to the UI
            pointRelUI = get(0, "PointerLocation") - app.UIFigure.Position(1:2);
            [s, z] = convertCoords(pointRelUI(1), pointRelUI(2));
            
            
            
            % Debugging purposes
            %disp("X/Y Coordinates: " + pointRelUI(1) + " " + pointRelUI(2));
            %disp("S/Z Coordinates: " + s + " " + z);
            
            
            
            
            
            % If there is no unit at this tile, check if a movement
            % indicator is visible here
            if app.movementIndicators(s,z).Visible == "on"
                %disp(app.targetedUnit);
                % Deselect the unit
                deselectUnit(app,app.targetedUnit.location(1),app.targetedUnit.location(2));
                
                % Move the targeted unit
                [app.tileOccupied, app.existingUnits] = moveUnit(app.existingUnits(app.targetedUnit.unitId), s, z, app.tileOccupied, app.existingUnits);
                
            else
                
                % If there is a unit at this tile, toggle selection
                
                % Validate the coordinates, and check if a unit is present
                if(validateCoords(s,z)) && app.tileOccupied(s,z) == true
                    
                    % Find which unit is on this tile
                    app.targetedUnit = whichUnit(app.existingUnits, s, z);
                    disp(app.targetedUnit);
                    
                    if app.targetedUnit.selected == false
                        % Select the unit
                        selectUnit(app,s,z);
                    else
                        % Deselect the unit
                        deselectUnit(app,s,z);
                        
                    end
                end
                
                
                
                
                % Move existingUnit(1), the first testUnit, to clicked location
                %[app.tileOccupied, app.existingUnits] = moveUnit(app.existingUnits(2), s, z, app.tileOccupied, app.existingUnits);
                
                
            end
            
            
            
        end
    end
    
    % Component Init
    methods (Access = private)
        function createComponents(app)
            % Determine what divider to use for file input
            % This changes if the host system is a PC or a Mac
            if ispc
                app.divider = '\';
            end
            if ismac
                app.divider = '/';
            end
            
            % Initialize values of tileOccupied
            for i = 1:15
                for j = 1:15
                    app.tileOccupied(i,j) = false;
                end
            end
            
            
            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure("Visible", "off");
            app.UIFigure.Position = [100 100 833 780];
            app.UIFigure.Name = "UI Figure"; % Name the ui figure "UI Figure"
            app.UIFigure.Resize = "off"; % Make the figure non-resizeable
            
            % Create Grid Image
            app.Grid = uiimage(app.UIFigure);
            app.Grid.Position = [1 9 833 772];
            app.Grid.ImageSource = "images" + app.divider + "grid.png";
            
            % Create all movement indicators (225 for 15x15 grid) and set to invisible
            app.movementIndicators = gobjects(15,15); % Creates an empty array of graphics objects
            
            for i = 1:15
                for j = 1:15
                    app.movementIndicators(i,j) = uiimage(app.UIFigure);
                    [app.movementIndicators(i,j).Position(1), app.movementIndicators(i,j).Position(2)] = leftCornerCoords(i, j); % Set position of movement indicators
                    app.movementIndicators(i,j).Position(3:4) = [43 40]; % Set size of movement indicators
                    app.movementIndicators(i,j).ImageSource = "images" + app.divider + "targeting_images" + app.divider + "blueCircle.png";
                    app.movementIndicators(i,j).Visible = "off";
                end
            end
            
            % Create Overlay
            app.Overlay = uiimage(app.UIFigure);
            app.Overlay.ImageClickedFcn = createCallbackFcn(app, @overlayClicked);
            app.Overlay.Position = [1 9 833 772];
            app.Overlay.ImageSource = "images" + app.divider + "transparent_overlay.png";
            
            % Create a test unit at (s,z) = (2,2)
            app.testUnit = unit(app.UIFigure, 5, 5, "testUnit", app.divider); %Create a test unit
            app.existingUnits(1) = app.testUnit; % Add to list of existing units
            app.tileOccupied(5,5) = true;
            
            % Create a second test unit at (s,z) = (5,2)
            app.testUnit2 = unit(app.UIFigure, 5, 2, "testUnit2", app.divider); %Create a test unit
            app.existingUnits(2) = app.testUnit2; % Add to list of existing units
            app.tileOccupied(5,2) = true;
            
            % Bring overlay to top
            app.UIFigure.Children = toTop(app.UIFigure.Children,findOverlay(app.UIFigure.Children, app.divider));
            
            % Show figure after all components created
            app.UIFigure.Visible = "on";
        end
        
        
        
        
        function selectUnit(app,s,z)
            % Turn on highlighter underneath unit
            app.movementIndicators(s,z).ImageSource = "images" + app.divider + "targeting_images" + app.divider + "highlight.png";
            app.movementIndicators(s,z).Visible = "on";
            
            %Calculate the correct tiles to highlight
            [movementTilesS, movementTilesZ] = getMovementTiles(app.targetedUnit.movementRange,s, z);
            
            % Display movement indicators
            for i = 1:length(movementTilesS)
                try
                    app.movementIndicators(movementTilesS(i),movementTilesZ(i)).Visible = "on";
                catch
                end
                
            end
            
            % Change status to selected
            app.existingUnits(app.targetedUnit.unitId).selected = true;
            
            % Change targeted unit
            
            
        end
        
        function deselectUnit(app,s,z)
            
            % Turn off highlighter underneath unit and reset image
            app.movementIndicators(s,z).ImageSource = "images" + app.divider + "targeting_images" + app.divider + "blueCircle.png";
            app.movementIndicators(s,z).Visible = "off";
            
            %Calculate the correct tiles to unhighlight
            [movementTilesS, movementTilesZ] = getMovementTiles(app.targetedUnit.movementRange,s, z);
            
            % Hide movement indicators
            for i = 1:length(movementTilesS)
                try
                    app.movementIndicators(movementTilesS(i),movementTilesZ(i)).Visible = "off";
                catch
                end
                
            end
            
            
            % Change status to not selected
            app.existingUnits(app.targetedUnit.unitId).selected = false;
        end
        
    end
    
    
    
    
    
    
    
    % App creation and deletion
    methods (Access = public)
        
        % Construct app
        function app = LOTF_Mk2
            
            % Create UIFigure and components
            createComponents(app);
            
            % Register the app with App Designer
            registerApp(app, app.UIFigure);
            
            if nargout == 0
                clear app
            end
        end
        
        % Code that executes before app deletion
        function delete(app)
            
            % Delete UIFigure when app is deleted
            delete(app.UIFigure);
        end
    end
    
end