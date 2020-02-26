% Title: Lord of the Fools
%
% Purpose: To create a strategy game resembling the Gameboy Advance SP Lord
% of the Rings The Third Age video game
% 
% Developers: Cameron Palmer and Henry Haggart
%
% Last Modified: Wednesday, February 26th, 2020
%
%
% Notes:
% Image location and size is defined by [x-coordrelui, y-coordrelui, width, height] 


classdef LOTF_Mk2 < matlab.apps.AppBase
    
    % Properties that correspond to app components
    properties (Access = public)
           
           UIFigure matlab.ui.Figure
           Grid matlab.ui.control.Image
           
    end
    
    % Callbacks that handle component events
    methods (Access = private)
        
        % Callback function for the grid image
        function gridImageClicked(app, event)
            % Find where the pointer is relative to the UI
            pointRelUI = get(0, 'PointerLocation') - app.UIFigure.Position(1:2);
            [s, z] = convertCoords(pointRelUI(1), pointRelUI(2));
            
            
        end
    end
    
    % Component Init
    methods (Access = private)
        function createComponents(app)
            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 833 780];
            app.UIFigure.Name = 'UI Figure';

            % Create Grid Image
            app.Grid = uiimage(app.UIFigure);
            app.Grid.ImageClickedFcn = createCallbackFcn(app, @gridImageClicked, true);
            app.Grid.Position = [1 9 833 772];
            app.Grid.ImageSource = 'grid.png';
            
            % Create a test unit
            %{
            testUnit = uiimage(app.UIFigure);
            [testUnit.Position(1), testUnit.Position(2)] = leftCornerCoords(4,2);
            testUnit.Position(1) = testUnit.Position(1);
            testUnit.Position(2) = testUnit.Position(2);
            testUnit.Position(3:4) = [43 40];
            testUnit.ImageSource = 'testUnit.png';
            %}
            
            testUnit = unit(app.UIFigure, 1, 3, 'testUnit');
           
            % Create all movement indicators (225 for 15x15 grid) and set to invisible
            movementIndicators = gobjects(15);
            
            for i = 1:15
                for j = 1:15
                    movementIndicators(i,j) = uiimage(app.UIFigure);
                    [movementIndicators(i,j).Position(1), movementIndicators(i,j).Position(2)] = leftCornerCoords(i, j);
                    movementIndicators(i,j).Position(1) = movementIndicators(i,j).Position(1);
                    movementIndicators(i,j).Position(2) = movementIndicators(i,j).Position(2);
                    movementIndicators(i,j).Position(3:4) = [43 40];
                    movementIndicators(i,j).ImageSource = 'blueCircle.png';
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