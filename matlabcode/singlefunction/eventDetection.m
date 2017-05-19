function [threshold, startEvent, eventVec] = eventDetection(longWindow, shortWindow, startFactor)
% event start and threshold determination
    threshold = rms(longWindow)^2;
    startEvent = 1 * (rms(shortWindow)^2 > threshold * startFactor); 
    eventVec = 0.1 * startEvent;% x event
end