function [threshold, startEvent, eventVec] = eventDetection(threshold, window, sample, startFactor)
% event start and threshold determination

    startEvent = 0;
    eventVec = [];
    threshold = rms(window)^2;

    if (rms(sample)^2 > threshold * startFactor)
        startEvent = 1;
        eventVec = 0.1;               % x event
    end
    
end