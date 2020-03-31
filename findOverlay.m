function index = findOverlay(figure)
% This function finds where the overlay is located in "figure"'s children
% and returns the index

    value = length(figure.Children);
    for i = 1:value
        
        if figure.Children(i).ImageSource == "images/transparent_overlay.png"
            index = i;
            
        end
    end

end