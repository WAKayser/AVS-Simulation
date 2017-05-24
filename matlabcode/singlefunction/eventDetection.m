function [threshold, startEvent, eventVec, prevDetect] = eventDetection(longWindow, shortWindow, startFactor, prevDetect)
% event start and threshold determination
    threshold = rms(longWindow)^2;
    if rms(shortWindow)^2 > threshold * startFactor
        if prevDetect
            startEvent = 1; 
            eventVec = 0.1 * startEvent;% x event
            prevDetect = 0;
        else
            prevDetect = 1;
            startEvent = 0;
            eventVec = 0;
        end
    else
        startEvent = 0;
        eventVec = 0;
        prevDetect = 0;
    end
end