function [eventVec, peakMatrix, timeStamp] = avsdspmodule(P, A, DSPparam)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    Fs = 16000;

    event = 0;
    eventVec = [];
    midFreqEst = [];
    peakVector = [];
    peakMatrix = [];
    timeStamp = [];
    threshold = 0;
    triggerCount = 0;
    % Window and sample initialization
    long = DSPparam.long;
    short = DSPparam.short;
    % long window P(index:long+index)
    % short window P(index+long:index+long+short)
    
    for index = long+1:(size(P, 1) - short)
        if ~event
            [threshold, event, triggerCount] = eventDetection(P(index - long:index), P(index:index+short), DSPparam.stFac, triggerCount, DSPparam.trig, threshold);
            eventVec(index) = 0.1 * event;
        else
            [eevent, highPeaks, event] = duringEvent(P(index:index+short), Fs, DSPparam, threshold); 
            [peakMatrix, peakVector] = peakUpdate(peakMatrix, peakVector, highPeaks);
            timeStamp = [timeStamp; index / Fs];
            eventVec(index) = eevent;
        end
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

    
