%function compare_test
close all;
clear;
%%
load('antinoise.mat')
%Create sensor data and AVS
%False positive test, 1 sec no events
Fs = 48000;
avsdata(:,:,1) = create_array(0, 0, 1, pi/2, 0); 
eventdata(1) = struct('type','cosine','delay',3,'duration',1,'amplitude', sqrt(2), 'freq', 10000, 'location', 1);
eventdata(2) = struct('type','cosine','delay',10,'duration',1,'amplitude',sqrt(2), 'freq', 5000, 'location', 1);
eventdata(3) = struct('type','cosine','delay',20,'duration',1,'amplitude',sqrt(3), 'freq', 3000, 'location', 1);
E = eventgen_multi(eventdata, 100);
%E = E(1:17:end,:,:);
%E = zeros(Fs*1000, 1);

[Z, Pz] = transform_multi(eventdata, avsdata, E);
N = noisegen(Z, 3, 2);
%A=1;
Pz = noisegen(Pz, 3, 2);
[P, A] = avsreceiver_multi(N, Pz, avsdata);
% plot(filter(antinoise, P))
%show_setup(eventdata,avsdata);

    %%
    %Give DSP parameters and detection margins
    DSPparam.Fs = Fs;
    DSPparam.long = Fs/2;                       % LTA parameter
    DSPparam.short = Fs/10;                       % STA parameter
    DSPparam.trig = 2500;                          % Trigger number
    DSPparam.stFac = 1.32;                         % event > threshold * factor
    DSPparam.endFac = 1.32;                        % event end < threshold * endFactor
    DSPparam.freqFac = 25;                       % used for detecting peaks
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