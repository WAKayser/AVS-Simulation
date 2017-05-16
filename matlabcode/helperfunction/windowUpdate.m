function [window, sample] = windowUpdate(inputArray, window, windowSize, sample, sampleSize, x);

    if length(inputArray) >= windowSize + (x+1)*sampleSize
        window = window([sampleSize + 1 : end 1 : sampleSize]);
        window(windowSize - sampleSize + 1 : windowSize) = sample;
        % get new sample
        sample = inputArray(windowSize+1 + x * sampleSize : windowSize + (x+1) * sampleSize);
    else
        break
    end

end

