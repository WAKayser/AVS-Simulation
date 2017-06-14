%function compare_test
close all;
clear;
%%
load('antinoise.mat')
%Create sensor data and AVS
%False positive test, 1 sec no events
Fs = 48000;
avsdata(:,:,1) = create_array(0, 0, 1, pi/2, 0); 
eventdata(1) = struct('type','cosine','delay',0.3,'duration',0.5,'amplitude', sqrt(2), 'freq',400, 'location', 1);
eventdata(2) = struct('type','cosine','delay',0.5,'duration',1,'amplitude',sqrt(2), 'freq',4763, 'location', 1);
eventdata(3) = struct('type','pulse','delay',2,'duration',0.1,'amplitude',2, 'freq',2577, 'location', 1);
E = eventgen_multi(eventdata, 3);
%E = E(1:17:end,:,:);
%E = zeros(Fs*1000, 1);

[Z, Pz] = transform_multi(eventdata, avsdata, E);
N = noisegen(Z, 14, 2);
%A=1;
Pz = noisegen(Pz, 14, 2);
[P, A] = avsreceiver_multi(N, Pz, avsdata);
% plot(filter(antinoise, P))
%show_setup(eventdata,avsdata);

    %%
    %Give DSP parameters and detection margins
    DSPparam.Fs = Fs;
    DSPparam.long = Fs/8;                       % LTA parameter
    DSPparam.short = Fs/40;                       % STA parameter
    DSPparam.trig = 80;                          % Trigger number
    DSPparam.stFac = 2;                         % event > threshold * factor
    DSPparam.endFac = 1.5;                        % event end < threshold * endFactor
    DSPparam.freqFac = 30;                       % used for detecting peaks
    param.start = DSPparam.short./Fs;         % Error margin on start time
    param.stop = DSPparam.short./Fs;          % Error margin on stop time
    param.freq = Fs/DSPparam.short;             % Error margin on signal frequency
    param.Fs = DSPparam.Fs;
    %%
    %Get detection results
    [eventVec, peakMatrix] = avsdspmodule_multi(P, A, DSPparam);
    [detection, success] = compare_multi(avsdata, eventdata, eventVec, peakMatrix, param);
    detection_plot(detection, eventVec * 10, peakMatrix, P)
%end