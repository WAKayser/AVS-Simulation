function [threshold, startEvent, eventVec] = eventDetection(window, sample, startFactor)
% event start and threshold determination
    threshold = rms(window)^2;
    startEvent = 1 * (rms(sample)^2 > threshold * startFactor); 
    eventVec = 0.1 * startEvent;% x event
end