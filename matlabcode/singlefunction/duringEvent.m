function [eventVec, highPeaks, startEvent] = duringEvent(sample, RMSSTA, MSSTA, DSPparam, threshold)
% Estimates frequency components when an event is detected.

    freqSample = abs(fft(sample));
    freqSample = freqSample(1 : floor(length(sample)/2));
    sampleMean = mean(freqSample);
    highPeaks = (find(freqSample > sampleMean*DSPparam.freqFac)-1)*DSPparam.Fs/DSPparam.short;

    % highPeaks = highPeaks(highPeaks > 500);
    % event end decision
    if (RMSSTA < threshold * DSPparam.endFac)
        startEvent = 0;
        eventVec = -0.1;          % x end event
    else 
        startEvent = 1;
        eventVec = 0;
    end

end
