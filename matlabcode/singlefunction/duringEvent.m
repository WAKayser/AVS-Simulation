function [eventVec, highPeaks, startEvent] = duringEvent(sample, Fs, DSPparam, threshold)
% Estimates frequency components when an event is detected.

    freqSample = abs(fft(sample));
    freqSample = freqSample([1 : length(sample)/2]);
    sampleMean = mean(freqSample);
    highPeaks = (find(freqSample > sampleMean*DSPparam.freqFac)-1)*Fs/DSPparam.short;

    % event end decision
    if (rms(sample)^2 < threshold * DSPparam.endFac)
        startEvent = 0;
        eventVec = -0.1;          % x end event
    else 
        startEvent = 1;
        eventVec = 0;
    end

end
