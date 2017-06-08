function [eventVec, peakMatrix] = avsdspmodule(P, A, DSPparam)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    event = 0;
    eventVec = zeros(size(P, 1), 1);
    midFreqEst = [];
    peakVector = [];
    peakMatrix = zeros(size(P, 1), 1);
    timeStamp = [];
    threshold = 0;
    triggerCount = 0;
    % Window and sample initialization
    long = DSPparam.long;
    short = DSPparam.short;
    
    longbegin = 1;
    longend = long;
    shortbegin = long;
    shortend = long + short;
    STA = mean(P(shortbegin:shortend));
    LTA = mean(P(1:longend));
    RMSSTA = rms(P(shortbegin:shortend));
    RMSLTA = rms(P(1:longend));
    MSSTA = RMSSTA^2;
    MSLTA = RMSLTA^2;
    
    % 
    % long window P(index:long+index)
    % short window P(index+long:index+long+short)
    
    for index = long+1:(size(P, 1) - short)
        shortend = shortend + 1;
        STA = STA - P(shortbegin)/short + P(shortend)/short;
        MSSTA = MSSTA - P(shortbegin)^2/short + P(shortend)^2/short;
        RMSSTA = sqrt(MSSTA);
        shortbegin = shortbegin + 1;
        if ~event
            longend = index;
            LTA = LTA - P(longbegin)/long + P(longend)/long;
            MSLTA = MSLTA - P(longbegin)/long + P(longend)/long;
            RMSLTA = sqrt(MSLTA);
            longbegin = longend - long;
            [threshold, event, triggerCount] = eventDetection(RMSLTA, RMSSTA, DSPparam.stFac, triggerCount, DSPparam.trig, threshold);
            eventVec(index) = 0.2 * event;
        end
        if event
            [eevent, highPeaks, event] = duringEvent(P(index:index+short), RMSSTA, MSSTA, DSPparam, threshold); 
            [peakMatrix, peakVector] = peakUpdate(peakMatrix, peakVector, highPeaks, index);
            eventVec(index) = eventVec(index) + eevent;
        end
    end
    % this is used to create the right size for plotting, without effecting it. 
    % cell usage because of the different sizes possible accross dspmodules
    peakMatrix = num2cell(peakMatrix,[1,2]);
end

    
