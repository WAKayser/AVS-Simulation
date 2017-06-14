function [eventVec, peakMatrix, peakVector] = avsdspmodule(P, A, DSPparam)
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
    RMSSTA = rms(P(shortbegin:shortend));
    RMSLTA = rms(P(1:longend));
    MSSTA = RMSSTA^2;
    MSLTA = RMSLTA^2;
    k = 0;
    % 
    % long window P(index:long+index)
    % short window P(index+long:index+long+short)
    
    for index = long+1:(size(P, 1) - short)
        shortend = shortend + 1;
        MSSTA = MSSTA - P(shortbegin)^2/short + P(shortend)^2/short;
        RMSSTA = sqrt(MSSTA);
        shortbegin = shortbegin + 1;
        if ~event
            MSLTA = MSLTA - MSLTA/long + P(index)^2/long;
            RMSLTA = sqrt(MSLTA);
            [threshold, event, triggerCount] = eventDetection(RMSLTA, RMSSTA, DSPparam.stFac, triggerCount, DSPparam.trig, threshold);
            eventVec(index) = 0.1 * event;
            k =0;
        end
        if event
            if ~k   
                [eevent, highPeaks, event] = duringEvent(P(index:index+short), RMSSTA, MSSTA, DSPparam, threshold); 
                k = short -1;
                [peakMatrix, peakVector] = peakUpdate(peakMatrix, peakVector, highPeaks, index);
                eventVec(index) = eventVec(index) + eevent;
            else
                k = k - 1;
                peakMatrix(index,:) =  peakMatrix(index-1,:);
            end
        end
    end
    % this is used to create the right size for plotting, without effecting it. 
    % cell usage because of the different sizes possible accross dspmodules
    peakMatrix = num2cell(peakMatrix,[1,2]);
    peakVector = num2cell(peakVector,[1,2]);
end

    
