function reordered = toTop(children, index)
% toTop(children, index) takes in an array of images called children and
% the index of the element to move to position 1. It then moves the element
% at children(index) to children(1).

    while index ~= 1
        children(index-1:index) = flip(children(index-1:index));
        index = index - 1;
    end
    
    reordered = children;

end