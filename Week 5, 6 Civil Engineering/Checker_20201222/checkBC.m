function [validity, condition] = checkBC(modelSupportCondition, supportCondition)
% Checks the correctness of the support condition.

if modelSupportCondition == supportCondition
    validity = true;
    if supportCondition == "+"
        condition = "fixed";
    elseif supportCondition == "-"
        condition = "free";
    else
        condition = "?";
    end % (if)
else
    validity = false;
end % (if)

end % (function)

