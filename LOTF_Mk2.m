% Title: Lord of the Fools
%
% Purpose: To create a strategy game resembling the Gameboy Advance SP Lord
% of the Rings The Third Age video game
% 
% Developers: Cameron Palmer and Henry Haggart
%
% Last Modified: Tuesday, March 31st, 2020 by Cameron Palmer
%
%
% Notes:
% Image location and size is defined by [x-coordrelui, y-coordrelui, width, height] 


classdef LOTF_Mk2 < matlab.apps.AppBase
    
    % Properties that correspond to app components
    properties (Access = public)
           
           UIFigure matlab.ui.Figure
           Grid matlab.ui.control.Image
           Overlay matlab.ui.control.Image
           testUnit
    end
    
    % Callbacks that handle component events
    methods (Access = private)
        
        % Callback function for the grid image
        
        
        function overlayClicked(app, event)
            % Find where the pointer is relative to the UI
            pointRelUI = get(0, 'PointerLocation') - app.UIFigure.Position(1:2);
            [s, z] = convertCoords(pointRelUI(1), pointRelUI(2));
            
            disp("X/Y Coordinates: " + pointRelUI(1) + " " + pointRelUI(2));
            disp("S/Z Coordinates: " + s + " " + z);
            
            app.testUnit.location(1:2) = [s,z];
            [app.testUnit.unitImage.Position(1), app.testUnit.unitImage.Position(2)] = leftCornerCoords(s,z);
        end
    end
    
    % Component Init
    methods (Access = private)
        function createComponents(app)
            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 833 780];
            app.UIFigure.Name = 'UI Figure'; % Name the ui figure "UI Figure"
            app.UIFigure.Resize = 'off'; % Make the figure non-resizeable

            % Create Grid Image
            app.Grid = uiimage(app.UIFigure);
            app.Grid.Position = [1 9 833 772];
            app.Grid.ImageSource = 'images/grid.png';
            
            % Create Overlay
            app.Overlay = uiimage(app.UIFigure);
            app.Overlay.ImageClickedFcn = createCallbackFcn(app, @overlayClicked);
            app.Overlay.Position = [1 9 833 772];
            app.Overlay.ImageSource = 'images/transparent_overlay.png';
            
            
            app.testUnit = unit(app.UIFigure, 5, 5, 'testUnit'); %Create a test unit
            
            % Bring overlay to top
            app.UIFigure.Children = toTop(app.UIFigure.Children,findOverlay(app.UIFigure.Children));
            
            
            % Create all movement indicators (225 for 15x15 grid) and set to invisible
            movementIndicators = gobjects(15); %Creates an empty array of graphics objects
            
            for i = 1:15
                for j = 1:15
                    movementIndicators(i,j) = uiimage(app.UIFigure);
                    [movementIndicators(i,j).Position(1), movementIndicators(i,j).Position(2)] = leftCornerCoords(i, j); % Set position of movement indicators
                    movementIndicators(i,j).Position(3:4) = [43 40]; % Set size of movement indicators
                    movementIndicators(i,j).ImageSource = 'images/targeting_images/blueCircle.png';
                    movementIndicators(i,j).Visible = 'off';
                end
            end
   
            % Show figure after all components created
            app.UIFigure.Visible = 'on';
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