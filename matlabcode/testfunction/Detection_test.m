%function Detection_test
%%
%Sensor and AVS at the same location
close all;
clear all;
Fs = 16000;
avsdata(:,:,1) = create_array(0, 0, 1, pi/2, 0);     %start, step, number, orientation, change
eventdata(1) = struct('type','cosine','delay',0.1,'duration',0.7,'amplitude',sqrt(2), 'freq', 1000, 'location', 0);
E = eventgen_multi(eventdata, 1);
A = 1;
xasFac = [];
xasDb = [];
Detect = [];
%%
%Parameters to be optimized
    DSPparam.short = 100;                       % STA parameter
    DSPparam.long = 5*DSPparam.short;           % LTA parameter
    param.start = 1*DSPparam.short./Fs;         % Error margin on start time
    param.stop = 1*DSPparam.short./Fs;          % Error margin on stop time
    param.freq = 1.5*Fs/DSPparam.short;         % Error margin on signal frequency
    DSPparam.bwFac = 0.9;                       % used for BW estimates
    
    xasFac=1:0.05:2;
    figure
    for k = 1:10 %SNR values
        xasDb = [xasDb; -8+0.5*k];
        legendInfo(k)=cellstr(['SNR = ' num2str(xasDb(k))]);
        for l = 1:length(xasFac)                                %aantal waardes van factor
            Detect(l,k) = 0;
            DSPparam.stFac = xasFac(l);                         % event > threshold * factor
            DSPparam.endFac = xasFac(l);                        % event end < threshold * endFactor
            for j = 1:10
                P(:,1,k) = noisegen(E(1:17:end,:,:), xasDb(k));
                [eventVec, peakMatrix, timeStamp] = avsdspmodule_multi(P(:,1,k), A, DSPparam);
                [detection(1,1,k), success] = compare_multi(avsdata, eventdata, eventVec, peakMatrix, param);
                Detect(l,k)= Detect(l,k) + 0.1*(isnan(detection(1,1,k).startdiff)*isnan(detection(1,1,k).stopdiff));
                %freqdiff(k)=detection(1,1,k).freqdiff;
            end
        end
        hold on;
        plot(xasFac,Detect(:,k))
    end
xlabel('Factor')
ylabel('Detection rate')
legend(legendInfo)
%end