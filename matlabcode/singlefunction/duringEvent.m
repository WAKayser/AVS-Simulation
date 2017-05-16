function [eventVec, midFreqEst, bwEst, highPeaks, startEvent] = duringEvent(sample, Fs, sampleSize, threshold, endFactor, bwFactor, startFactor)
% Estimates BW and frequency components when an event is detected.

    startEvent = 1;
    eventVec = [];

    fDomSample = fft(sample);
    samplePower = fDomSample.*conj(fDomSample);

    % frequency estimation
    [amplitude, maxIndex] = max(samplePower);
    midFreqEst = (maxIndex-1)*Fs/(sampleSize);

    % BW estimation
    bwEst =  bwEstimate(samplePower, bwFactor, sampleSize, Fs);

     % multiple signal detection, second try
    [estimatedComponents, highPeaks] = multiDetection(samplePower, threshold, startFactor, sampleSize, Fs);

    
    % event end decision
   % if sum(samplePower)/sampleSize^2 < threshold * endFactor
    if (rms(sample)^2 < threshold * endFactor)
        startEvent = 0;
        eventVec = -0.1;          % x end event
    end     

end
