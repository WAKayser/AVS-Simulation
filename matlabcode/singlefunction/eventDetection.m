function [threshold, event, triggerCount] = eventDetection(RMSLTA, RMSSTA, stFac, triggerCount, trig, threshold)
% event start and threshold determination
    if ~triggerCount
        threshold = RMSLTA;
    end
%     threshold = threshold
%     startFactor = startFactor
%     RMSSTA = RMSSTA
    
    if (RMSSTA) > threshold * stFac
        if triggerCount == triggerNumber
            event = 1;
            triggerCount = 0;
        else
            triggerCount = triggerCount + 1;
            event = 0;
        end
    else
        event = 0;
        triggerCount = 0;
    end
end
