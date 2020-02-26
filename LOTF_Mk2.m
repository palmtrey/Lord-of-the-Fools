classdef LOTF_Mk2 < matlab.apps.AppBase
    % Properties that correspond to app components
    properties (Access = public)
           
           UIFigure matlab.ui.Figure
           Image matlab.ui.control.Image
    end
    
    % Callbacks that handle component events
    methods (Access = private)
        
        % Callback function for image
        function gridImageClicked(app, event)
            % Find where the pointer is relative to the UI
            pointRelUI = get(0, 'PointerLocation') - app.UIFigure.Position(1:2);
            [s, z] = convertCoords(pointRelUI(1), pointRelUI(2));
            
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
            app.Image = uiimage(app.UIFigure);
            app.Image.ImageClickedFcn = createCallbackFcn(app, @gridImageClicked, true);
            app.Image.Position = [1 9 833 772];
            app.Image.ImageSource = 'Square.png';
            

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
            %registerApp(app, app.UIFigure2);
            
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