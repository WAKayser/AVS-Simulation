function [eevent, highPeaks, event] = duringEvent(sample, RMSSTA, DSPparam, threshold)
% Estimates frequency components when an event is detected.
    load('antinoise.mat')
    sample = filter(antinoise, sample);
    freqSample = abs(fft(sample));
    freqSample = freqSample(1 : floor(length(sample)/2));
    sampleMean = mean(freqSample);
    highPeaks = (find(freqSample > sampleMean*DSPparam.freqFac)-1)*DSPparam.Fs/DSPparam.short;

    % highPeaks = highPeaks(highPeaks > 500);
    % event end decision
    if (RMSSTA < threshold * DSPparam.endFac)
        event = 0;
        eevent = -0.1;          % x end event
    else 
        event = 1;
        eevent = 0;
    end

end
