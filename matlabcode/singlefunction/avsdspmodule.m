function [eventVec, peakMatrix, timeStamp] = avsdspmodule(P, A)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    longSize = 1000;                     % LTA parameter
    shortSize = 200;                      % STA parameter
    startFactor = 5;                       % event > threshold * factor
    endFactor = 3;                         % event end < threshold * endFactor

    % Other parameters and initializations
    bwFactor = 0.9;                        % used for BW estimates
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
    longWindow = P(1:longSize);
    shortWindow = P(longSize+1 : longSize+shortSize);
    x = 0;
    while(length(P) > longSize + (x+2)*shortSize)
        x = x + 1;
        % detection and threshold update
        eventVec(x*shortSize + longSize) = 0;
        if startEvent == 0 % Not during event
            [threshold, startEvent, sevent] = eventDetection(longWindow, shortWindow, startFactor);
            eventVec(x*shortSize + longSize) = sevent;
        end
        if startEvent == 1 % During Event
            [eevent, midFreqEst(x), bwEst(x), highPeaks, startEvent] = duringEvent(shortWindow, Fs, shortSize, threshold, endFactor, bwFactor, startFactor);        
            [peakMatrix, peakVector] = peakUpdate(peakMatrix, peakVector, highPeaks);
            timeStamp = [timeStamp; (longSize + (x) * shortSize) / Fs];
            eventVec(x*shortSize + longSize) = eventVec(x*shortSize + longSize) + eevent;
        end
       
        longWindow = longWindow([shortSize + 1 : end 1 : shortSize]);
        longWindow(longSize - shortSize + 1 : longSize) = shortWindow;
        % get new sample
        shortWindow = P(longSize+1 + x * shortSize : longSize + (x+1) * shortSize);
    end
    if isempty(timeStamp)
        timeStamp = nan;
        peakMatrix = nan;
    end
end

    