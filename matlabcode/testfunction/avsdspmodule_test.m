function avsdspmodule_test
%AVSDSPMODULE_TEST fill in the values needed to test the avsdspmodule
%   avsdspmodule_multi will return an 5array of detected data structs
    Fs = 16000;
    avsdata(:,:,1) = create_array(0, 50, 1, pi, 0);
    eventdata(1) = struct('type','cosine','delay',0.5,'duration',0.1,'amplitude',100, 'freq', 2000, 'location', -1000+800j);
    eventdata(2) = struct('type','cosine','delay',0.4,'duration',0.15,'amplitude',100, 'freq', 960, 'location', -1000+800j);

    E = eventgen_multi(eventdata, 1);
    Z = transform_multi(eventdata, avsdata, E);
    N = noisegen(Z, 55);
    [P, A] = avsreceiver_multi(N, avsdata);
    
    [eventVec, peakMatrix, timeStamp] = avsdspmodule_multi(P, A);
    
    % Doe hier iets met visualisatie van waveform en eventdetection
    subplot(211)
    tas = (1:size(P, 1))./Fs;     
    hold on;
    plot(tas,P)
    % eventVec filtering
    tas2 = (1:length(eventVec))./Fs;     
    eventVec(eventVec==0) = nan ;
    plot(tas2,eventVec,'x')

    subplot(212)
    size(timeStamp)
    size(peakMatrix(1:end,:,1,1))
    plot(timeStamp, peakMatrix(1:end,:,1,1));
    
end

