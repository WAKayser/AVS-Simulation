function D = avsdspmodule_test
%AVSDSPMODULE_TEST fill in the values needed to test the avsdspmodule
%   avsdspmodule_multi will return an 5array of detecteddata structs

% Sta/Lta parameters
windowSize = 1000;                     % LTA parameter
sampleSize = 400;                      % STA parameter
startFactor = 5;                       % event > threshold * factor
endFactor = 3;                         % event end < threshold * endFactor

% Other parameters and initializations
plotSize = 16000;                      % size of array that gets plotted
bwFactor = 0.9;                        % used for BW estimates
Fs = 16000;

startEvent = 0;
stopEvent = 0;
peakInit = 0;
x = 0;                                  % time stamp
mean = [];
BW = [];
eventVec = [];
bwEst = [];
midFreqEst = [];
tempPeaks = [];
peakVector = [0];
peakMatrix = [0];
threshold = 0;


avsdata(:,:,1) = create_array(0, 50, 2, pi, 0);
avsdata(:,:,2) = create_array(5000, 50, 2, 0, pi);

%eventdata(1) = struct('type','pulse','delay',0.25,'duration',0.1,'amplitude',10, 'freq', 0, 'location', 500+200j);
eventdata(1) = struct('type','cosine','delay',0.5,'duration',0.1,'amplitude',100, 'freq', 2000, 'location', -1000+800j);

E = eventgen_multi(eventdata, 1);
Z = transform_multi(eventdata, avsdata, E);
N = noisegen(Z, 55);

[P, A] = avsreceiver_multi(N, avsdata);

inputArray = P(:,1,1);

if plotSize > length(inputArray)
    plotSize = length(inputArray);
end

    % Window and sample initialization
    window = inputArray(1:windowSize);
    sample = inputArray(windowSize+1 : windowSize+sampleSize);
    x = 0;


while(1)
    x = x + 1;

    % detection and threshold update
    if startEvent == 0
        [threshold, startEvent, eventVecTemp] = eventDetection(threshold, window, sample, startFactor);
    end
   % eventVecTemp
    
   if length(eventVecTemp) ~= 0
        eventVec(x*sampleSize) = eventVecTemp;
   end
        
    % during event
    if startEvent == 1
        [eventVecTemp, midFreqEst(x), bwEst(x), highPeaks, startEvent] = duringEvent(sample, Fs, sampleSize, threshold, endFactor, bwFactor, startFactor);        
        [peakMatrix, peakVector] = peakUpdate(peakMatrix, peakVector, highPeaks);
    end

    if length(eventVecTemp) ~= 0
        eventVec(x*sampleSize) = eventVecTemp;
    end
    
    if length(inputArray) >= windowSize + (x+1)*sampleSize
        window = window([sampleSize + 1 : end 1 : sampleSize]);
        window(windowSize - sampleSize + 1 : windowSize) = sample;
        % get new sample
        sample = inputArray(windowSize+1 + x * sampleSize : windowSize + (x+1) * sampleSize);
    else
        break
    end
end

visualize(inputArray, Fs, plotSize, sampleSize, eventVec, midFreqEst, bwEst, peakMatrix);


end

