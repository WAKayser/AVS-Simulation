%function compare_test
close all;
clear all;
%%
%Create sensor data and AVS
%False positive test, 1 sec no events
Fs = 16000;
avsdata(:,:,1) = create_array(0, 0, 1, pi/2, 0); 
eventdata(1) = struct('type','cosine','delay',0,'duration',0,'amplitude',0, 'freq', 0, 'location', 0);
% E = eventgen_multi(eventdata, 100);
% E = E(1:17:end,:,:);
E = zeros(Fs*1000, 1);

%[Z, Pz] = transform_multi(eventdata, avsdata, E);
P = noisegen(E, 0);
A=1;
%Pz = noisegen(Pz, 60);
%[P, A] = avsreceiver_multi(N, Pz, avsdata);
%show_setup(eventdata,avsdata);

    %%
    %Give DSP parameters and detection margins
    DSPparam.long = 2000;                       % LTA parameter
    DSPparam.short = 400;                       % STA parameter
    DSPparam.stFac = 1.1;                         % event > threshold * factor
    DSPparam.endFac = 1.1;                        % event end < threshold * endFactor
    %DSPparam.bwFac = 0.9;                       % used for BW estimates
    param.start = DSPparam.short./Fs;         % Error margin on start time
    param.stop = DSPparam.short./Fs;          % Error margin on stop time
    param.freq = Fs/DSPparam.short;             % Error margin on signal frequency
    
    %%
    %Get detection results
    [eventVec, peakMatrix, timeStamp] = avsdspmodule_multi(P, A, DSPparam);
    [detection, success] = compare_multi(avsdata, eventdata, eventVec, peakMatrix, param);
     
    detection_plot(detection, eventVec, peakMatrix, timeStamp, P)
%end