function [threshold, startEvent, eventVec, prevDetect] = eventDetection(longWindow, shortWindow, startFactor, prevDetect)
% event start and threshold determination
    % Detemine the LTA of the system. 
    threshold = rms(longWindow)^2;
    % check if the STA is higher than the treshold times a predetermined factor
    % this has been chosen after many simulations. 
    if rms(shortWindow)^2 > threshold * startFactor
        % Simple state machine that implements rudimentary trigger counter of two. 
        if prevDetect
            % event has twice been detected
            startEvent = 1; 
            eventVec = 0.1;% x event
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
