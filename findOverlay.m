function index = findOverlay(children, divider)
% FindOverlay(children) takes in an array of images children and finds
% which image has the ImageSource property equal to
% "images/transparent_overlay.png", effectively finding the location of the
% transparent overlay within the array children.

    value = length(children);
    for i = 1:value
        
        if children(i).ImageSource == "images" + divider + "transparent_overlay.png"
            index = i;
            
        end
    end

end