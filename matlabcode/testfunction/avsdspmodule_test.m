function avsdspmodule_test
%AVSDSPMODULE_TEST fill in the values needed to test the avsdspmodule
%   avsdspmodule_multi will return an 5array of detecteddata structs

    % Sta/Lta parameters
    longSize = 1000;                     % LTA parameter
    shortSize = 400;                      % STA parameter
    startFactor = 5;                       % event > threshold * factor
    endFactor = 3;                         % event end < threshold * endFactor

    % Other parameters and initializations
    plotSize = 16000;                      % size of array that gets plotted
    bwFactor = 0.9;                        % used for BW estimates
    Fs = 16000;

    startEvent = 0;
    eventVec = [];
    bwEst = [];
    midFreqEst = [];
    peakVector = 0;
    peakMatrix = 0;
    threshold = 0;


    avsdata(:,:,1) = create_array(0, 50, 1, pi, 0);
    eventdata(1) = struct('type','cosine','delay',0.5,'duration',0.1,'amplitude',100, 'freq', 2000, 'location', -1000+800j);

    E = eventgen_multi(eventdata, 1);
    Z = transform_multi(eventdata, avsdata, E);
    N = noisegen(Z, 55);
    [P, A] = avsreceiver_multi(N, avsdata);

    if plotSize > length(P)
        plotSize = length(P);
    end

    % Window and sample initialization
    longWindow = P(1:longSize);
    shortWindow = P(longSize+1 : longSize+shortSize);
    x = 0;
    while(length(P) > longSize + (x+2)*shortSize)
        x = x + 1;
        % detection and threshold update
        if startEvent == 0 % Not during event
            [threshold, startEvent, event] = eventDetection(longWindow, shortWindow, startFactor);
        elseif startEvent == 1 % During Event
            [event, midFreqEst(x), bwEst(x), highPeaks, startEvent] = duringEvent(shortWindow, Fs, shortSize, threshold, endFactor, bwFactor, startFactor);        
            [peakMatrix, peakVector] = peakUpdate(peakMatrix, peakVector, highPeaks);
        end
        eventVec(x*shortSize) = event;
       
        longWindow = longWindow([shortSize + 1 : end 1 : shortSize]);
        longWindow(longSize - shortSize + 1 : longSize) = shortWindow;
        % get new sample
        shortWindow = P(longSize+1 + x * shortSize : longSize + (x+1) * shortSize);
    end

    visualize(P, Fs, plotSize, shortSize, eventVec, midFreqEst, bwEst, peakMatrix);
end

