function avsdspmodule_test
%AVSDSPMODULE_TEST fill in the values needed to test the avsdspmodule
%   avsdspmodule_multi will return an 5array of detected data structs
Fs = 16000;
avsdata(:,:,1) = create_array(0, 50, 1, pi, 0);
eventdata(1) = struct('type','cosine','delay',0.2,'duration',0.1,'amplitude',1, 'freq', 5000, 'location', 20);
eventdata(2) = struct('type','cosine','delay',0.7,'duration',0.15,'amplitude',1, 'freq', 394, 'location', 20);
eventdata(3) = struct('type','cosine','delay',0.4,'duration',0.2,'amplitude',1, 'freq', 3000, 'location', 15+15j);

E = eventgen_multi(eventdata, 1);
Z = transform_multi(eventdata, avsdata, E);
N = noisegen(Z, 20);
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

