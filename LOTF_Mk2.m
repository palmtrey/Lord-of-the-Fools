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
            
            if (s == 1 && z == 1)
                redSquare1 = uiimage(app.UIFigure);
                redSquare1.Position(1:2) = [769 12];
                redSquare1.Position(3:4) = [53 50];
                redSquare1.ImageSource = 'blueCircle.png';
                addprop(redSquare1, 'coordinates');
                redSquare1.coordinates = [1,1];
            end
            if (s == 2 && z == 2)
                redSquare2 = uiimage(app.UIFigure);
                redSquare2.Position = [67 63 53 50];
                redSquare2.ImageSource = 'redSquare.png';
            end
            if (s == 2 && z == 1)
               blueCircle1 = uiimage(app.UIFigure);
               blueCircle1.Position = [72 17 43 40];
               blueCircle1.ImageSource = 'blueCircle.png';
               
            end
            if (s == 1 && z == 2)
               blueCircle3 = uiimage(app.UIFigure);
               blueCircle3.Position = [13 63 53 50];
               blueCircle3.ImageSource = 'blueCircle.png';
            end
            disp(s);
            disp(z);
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
            
            % Create all movement indicators and set to invisible
            movementIndicators = gobjects(15);
            movementIndicators(3,2) = uiimage(app.UIFigure); 
            movementIndicators(3,2).Position = [126 68 43 40];
            movementIndicators(3,2).ImageSource = 'blueCircle.png';

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