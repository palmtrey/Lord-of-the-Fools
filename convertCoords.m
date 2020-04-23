function [s, z] = convertCoords(x, y)
%The function convertCoords takes in a pair of coordinates x(13:810) and y(10:780) and
%returns the corresponding grid location s(1:15) and z(1:15)
    
    s=0;
    z=0;

    
    i = 0;
    for i = 0:14
       checkX = (x-13-2*i)/52;
       if all(checkX > i & checkX < i + 1)
           s = i + 1;
           
       else
           i = i + 1;
       end
    end

    
    j = 0;
    for j = 0:14
        checkY = (y-10-2*j)/50;
        if all(checkY > j & checkY < j + 1)
            z = j + 1;
            
        else
            j = j + 1;
        end
        
    end
end

