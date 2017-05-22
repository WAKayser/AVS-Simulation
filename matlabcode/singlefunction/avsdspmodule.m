function [eventVec, peakMatrix, timeStamp] = avsdspmodule(P, A, DSPparam)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    Fs = 16000;

    startEvent = 0;
    eventVec = [];
    bwEst = [];
    midFreqEst = [];
    peakVector = [];
    peakMatrix = [];
    timeStamp = [];
    threshold = 0;

        % Window and sample initialization
    longWindow = P(1:DSPparam.long);
    shortWindow = P(DSPparam.long+1 : DSPparam.long+DSPparam.short);
    x = 0;
    while(length(P) > DSPparam.long + (x+2)*DSPparam.short)
        % detection and threshold update
        eventVec(x*DSPparam.short + DSPparam.long) = 0;
        if startEvent == 0 % Not during event
            [threshold, startEvent, sevent] = eventDetection(longWindow, shortWindow, DSPparam.stFac);
            eventVec(x*DSPparam.short + DSPparam.long) = sevent;
        end
        if startEvent == 1 % During Event
            [eevent, midFreqEst(x+1), bwEst(x+1), highPeaks, startEvent] = duringEvent(shortWindow, Fs, DSPparam.short, threshold, DSPparam.endFac, DSPparam.bwFac, DSPparam.stFac);        
            [peakMatrix, peakVector] = peakUpdate(peakMatrix, peakVector, highPeaks);
            timeStamp = [timeStamp; (DSPparam.long + x * DSPparam.short) / Fs];
            eventVec(x*DSPparam.short + DSPparam.long) = eventVec(x*DSPparam.short + DSPparam.long) + eevent;
        end
       
        longWindow = longWindow([DSPparam.short + 1 : end 1 : DSPparam.short]);
        longWindow(DSPparam.long - DSPparam.short + 1 : DSPparam.long) = shortWindow;
        % get new sample
        x = x + 1;
        shortWindow = P(DSPparam.long+1 + x * DSPparam.short : DSPparam.long + (x+1) * DSPparam.short);
    end
    if isempty(timeStamp)
        timeStamp = nan;
        peakMatrix = nan;
    end
    peakMatrix = num2cell(peakMatrix,[1,2]);
    timeStamp = num2cell(timeStamp,[1]);
end

    