% clear all;
% close all;
%%

% Reference = load('Ref.mat');
% %sin3k90 = daqread('Sinusoid_3k_DOA90_10s.1.daq');
% %Sweep1k2k90 = daqread('Sweep_1k_2k_DOA90_30s.1.daq');
% %Metal60 = daqread('Metal_DOA60_10s.2.daq');
% %Impulse45 = daqread('Impulse_DOAneg45_10s.1.daq');
% %Drone90 = daqread('Drone_DOA90_10s.1.daq');
% Droneheenweer = daqread('Droneflying_heenweer_30s.1.daq');
% %Sweep2k3k45 = daqread('Sweep2k_3k_DOAneg45_30s.1.daq');
% %sin5k60 = daqread('Sinus_5k_DOAneg60_10s.1.daq');
% %%FILT
% 
 antinoise = load('antinoise.mat');
%     
% sig = [Sweep2k3k45; Reference.Ref]; %Select signal
%P = sig(1:end,1:4:end); 
A = 1;
P = DataChan1_Y_Data;

avsdata(:,:,1) = create_array(0, 0.05, 1, pi/2, 0);  %start, step, number, orientation, change
eventdata(1) = struct('type','cosine','delay',0,'duration',0 ,'amplitude', 0, 'freq', 0, 'location', 0);

DSPparam.Fs = 48000;
DSPparam.long = DSPparam.Fs/2;                  % LTA parameter
DSPparam.short = DSPparam.Fs/10;                % STA parameter
DSPparam.trig = 100;                            % Trigger number
DSPparam.stFac = 1.4;                           % event > threshold * factor
DSPparam.endFac = 1.4;                          % event end < threshold * endFactor
DSPparam.freqFac = 20;                          % used for detecting peaks
param.start = 300;                              % Error margin on start time
param.stop = 300;                              % Error margin on stop time
param.freq = DSPparam.Fs/DSPparam.short;        % Error margin on signal frequency
param.Fs =  48000;

%%
%
%[eventVec(:,1), peakMatrix, timeStamp] = avsdspmodule(P(:,1), A, DSPparam);
%[detection, success] = compare(avsdata, eventdata, eventVec, cell2mat(peakMatrix), param);
%detection_plot(detection, eventVec, peakMatrix, timeStamp, P(:,1))
for k = 1:1
    F(:,k) = filter(antinoise.antinoise, P(:,k));
    [eventVec(:,k), peakMatrix, peakVector] = avsdspmodule(F(:,k), A, DSPparam);
    [detection, ~] = compare(avsdata, eventdata, eventVec(:,k), cell2mat(peakVector), param);
    detection_plot(detection, eventVec(:,k), peakMatrix, F(:,k));
end