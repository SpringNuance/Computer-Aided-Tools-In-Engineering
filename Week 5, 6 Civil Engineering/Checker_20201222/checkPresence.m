function [validity, presence] = checkPresence(modelLoadPresence, loadPresence)
% Check for correctness:
% + presence in the calculation

if modelLoadPresence == loadPresence
    validity = true;
    if loadPresence == "+"
        presence = "on";
    elseif loadPresence == "-"
        presence = "off";
    else
        presence = "?";
    end % (if)
else
    validity = false;
end % (if)

end % (function)

