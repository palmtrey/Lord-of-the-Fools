function [bool] = inRange(check,against, range)
% inRange(check, against, range) takes in a 1-value "check" double or integer to test.
% If the value of "check" is within the range "against" +- "range", the
% function returns true. Otherwise, it returns false.

upper = against + range;
lower = against - range;

if check <= upper && check >= lower
    bool = true;
else
    bool = false;
end
end

