function [threshold, startEvent, triggerCount] = eventDetection(longWindow, shortWindow, startFactor, triggerCount, triggerNumber, threshold)
% event start and threshold determination
<<<<<<< HEAD
    if triggerCount == 0 
    threshold = rms(longWindow)^2;
    end
    
    if rms(shortWindow)^2 > threshold * startFactor
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
