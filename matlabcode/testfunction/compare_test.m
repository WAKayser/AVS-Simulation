%function compare_test
close all;
clear;
%%
%Create sensor data and AVS
%False positive test, 1 sec no events
Fs = 16000;
avsdata(:,:,1) = create_array(0, 0, 1, pi/2, 0); 
eventdata(1) = struct('type','cosine','delay',0.3,'duration',0.5,'amplitude', sqrt(2), 'freq',400, 'location', 1);
eventdata(2) = struct('type','cosine','delay',0.5,'duration',1,'amplitude',sqrt(2), 'freq',4763, 'location', 1);
eventdata(3) = struct('type','pulse','delay',2,'duration',0.1,'amplitude',sqrt(2), 'freq',2577, 'location', 1);
E = eventgen_multi(eventdata, 3);
%E = E(1:17:end,:,:);
%E = zeros(Fs*1000, 1);

[Z, Pz] = transform_multi(eventdata, avsdata, E);
N = noisegen(Z, 20);
%A=1;
Pz = noisegen(Pz, 20);
[P, A] = avsreceiver_multi(N, Pz, avsdata);
%show_setup(eventdata,avsdata);

    %%
    %Give DSP parameters and detection margins
    DSPparam.Fs = Fs;
    DSPparam.long = 2000;                       % LTA parameter
    DSPparam.short = 400;                       % STA parameter
    DSPparam.trig = 10;                          % Trigger number
    DSPparam.stFac = 2;                         % event > threshold * factor
    DSPparam.endFac = 2;                        % event end < threshold * endFactor
    DSPparam.freqFac = 20;                       % used for detecting peaks
    param.start = DSPparam.short./Fs;         % Error margin on start time
    param.stop = DSPparam.short./Fs;          % Error margin on stop time
    param.freq = Fs/DSPparam.short;             % Error margin on signal frequency
    
    %%
    %Get detection results
    [eventVec, peakMatrix] = avsdspmodule_multi(P, A, DSPparam);
    [detection, success] = compare_multi(avsdata, eventdata, eventVec, peakMatrix, param);
    detection_plot(detection, eventVec, peakMatrix, P)
%end