function [estimatedComponents, highPeaks] = multiDetection(samplePower, threshold, factor, sampleSize, Fs)
% finds peaks seperated by 2 samples, higher than the threshold*factor.

    [amp, peaks] = findpeaks(samplePower([1:ceil(length(samplePower)/2)]));
    
    indices = find(amp > threshold * factor * sampleSize^2);
    highPeaks = peaks(indices);
    highPeaks = (highPeaks - ones(length(highPeaks),1)).*Fs/sampleSize;
    highAmps = amp(indices);

    estimatedComponents = length(highPeaks);
    
end