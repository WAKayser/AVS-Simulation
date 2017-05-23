%function compare_test
close all;
clear all;
%%
%Create sensor data and AVS
Fs = 16000;
avsdata(:,:,1) = create_array(-5, 5, 3, pi/2, 0);     %start, step, number, orientation, change
%avsdata(:,:,2) = create_array(10, 1, 1, 0, pi);

eventdata(1) = struct('type','cosine','delay',0.1,'duration',0.1,'amplitude',1, 'freq', 4000, 'location', 5j); %'up', 0.01, 'down', 0.01,
eventdata(2) = struct('type','cosine','delay',0.3,'duration',0.1,'amplitude',1, 'freq', 300, 'location', 15j);
eventdata(3) = struct('type','cosine','delay',0.5,'duration',0.1,'amplitude',1, 'freq', 3100, 'location', -10+10j);
eventdata(4) = struct('type','pulse','delay',0.7,'duration',0.05,'amplitude',1, 'freq', 5, 'location', 20+5j);
eventdata(5) = struct('type','cosine','delay',0,'duration',0.1,'amplitude',1, 'freq', 1000, 'location', 1000j);

E = eventgen_multi(eventdata, 4);
[Z, Pz] = transform_multi(eventdata, avsdata, E);
N = noisegen(Z, 60);
Pz = noisegen(Pz, 60);
[P, A] = avsreceiver_multi(N, Pz, avsdata);
show_setup(eventdata,avsdata);

    %%
    %Give DSP parameters and detection margins
    DSPparam.long = 1000;                       % LTA parameter
    DSPparam.short = 200;                       % STA parameter
    DSPparam.stFac = 5;                         % event > threshold * factor
    DSPparam.endFac = 3;                        % event end < threshold * endFactor
    DSPparam.bwFac = 0.9;                       % used for BW estimates
    param.start = 3*DSPparam.short./Fs;         % Error margin on start time
    param.stop = 3*DSPparam.short./Fs;          % Error margin on stop time
    param.freq = 1.5*Fs/DSPparam.short;             % Error margin on signal frequency
    
    %%
    %Get detection results
    [eventVec, peakMatrix, timeStamp] = avsdspmodule_multi(P, A, DSPparam);
    [detection, success] = compare_multi(avsdata, eventdata, eventVec, peakMatrix, param);
     
detection_plot(detection, eventVec, peakMatrix, timeStamp, P)
%end