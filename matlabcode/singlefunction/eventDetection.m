function [threshold, startEvent, triggerCount] = eventDetection(RMSLTA, RMSSTA, startFactor, triggerCount, triggerNumber, threshold)
% event start and threshold determination
    if ~triggerCount
        threshold = RMSLTA;
    end
%     threshold = threshold
%     startFactor = startFactor
%     RMSSTA = RMSSTA
    
    if (RMSSTA) > threshold * startFactor
        if triggerCount == triggerNumber
            startEvent = 1;
            triggerCount = 0;
        else
            triggerCount = triggerCount + 1;
            startEvent = 0;
        end
    else
        startEvent = 0;
        triggerCount = 0;
    end
end
