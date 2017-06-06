function [eventVec, peakMatrix, timeStamp] = avsdspmodule(P, A, DSPparam)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    Fs = 16000;

    startEvent = 0;
    eventVec = [];
    midFreqEst = [];
    peakVector = [];
    peakMatrix = [];
    timeStamp = [];
    threshold = 0;
    triggerCount = 0;
        % Window and sample initialization
    longWindow = P(1:DSPparam.long);
    shortWindow = P(DSPparam.long+1 : DSPparam.long+DSPparam.short);
    x = 0;
    while(length(P) > DSPparam.long + (x+2)*DSPparam.short)
        %detection and threshold update
        eventVec(x*DSPparam.short + DSPparam.long) = 0;
        if startEvent == 0 % Not during event
            [threshold, startEvent, triggerCount] = eventDetection(longWindow, shortWindow, DSPparam.stFac, triggerCount, DSPparam.trig, threshold);
            if startEvent == 1
                eventVec((x - DSPparam.trig)*DSPparam.short + DSPparam.long ) = 0.1;
            end
        end
        if startEvent == 1 % During Event
            [eevent, highPeaks, startEvent] = duringEvent(shortWindow, Fs, DSPparam, threshold);        
            [peakMatrix, peakVector] = peakUpdate(peakMatrix, peakVector, highPeaks);
            % create time stamps for the events
            timeStamp = [timeStamp; (DSPparam.long + x * DSPparam.short) / Fs];
            % create a stop event when the event stopped. 
            eventVec(x*DSPparam.short + DSPparam.long) = eventVec(x*DSPparam.short + DSPparam.long) + eevent;
        end
        
        %% append the new shortwindow to the long window
        longWindow = longWindow([DSPparam.short + 1 : end 1 : DSPparam.short]);
        
        %% remove the oldest shortwindow from the longwindow
        longWindow(DSPparam.long - DSPparam.short + 1 : DSPparam.long) = shortWindow;
        % Determine a newe shortwindow.
        x = x + 1;
        shortWindow = P(DSPparam.long+1 + x * DSPparam.short : DSPparam.long + (x+1) * DSPparam.short);
    end
    % this is used to create the right size for plotting, without effecting it. 
    if isempty(timeStamp)
        timeStamp = nan;
        peakMatrix = nan;
    end
    % cell usage because of the different sizes possible accross dspmodules
    peakMatrix = num2cell(peakMatrix,[1,2]);
    timeStamp = num2cell(timeStamp,[1]);
end

    
