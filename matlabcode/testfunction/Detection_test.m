%function Detection_test
%%
close all;
clear all;
Fs = 16000;
%AVSdata for signal detection
avsdata(:,:,1) = create_array(0, 0, 1, pi/2, 0);     %start, step, number, orientation, change
eventdata(1) = struct('type','cosine','delay',0.2,'duration',0.2,'amplitude', sqrt(2), 'freq', 1000, 'location', 0);
E = eventgen_multi(eventdata, 0.6);
E = E(1:17:end,:,:);
A = 1;
xasFac = [];
xasDb = [];
Detect = [];
%%
%Parameters to be optimized
    DSPparam.short = 400;                       % STA parameter
    DSPparam.long = 5*DSPparam.short;           % LTA parameter
    param.start = DSPparam.short./Fs;         % Error margin on start time
    param.stop = DSPparam.short./Fs;          % Error margin on stop time
    param.freq = 1.5*Fs/DSPparam.short;         % Error margin on signal frequency
    %DSPparam.bwFac = 0.9;                       % used for BW estimates
    
    xasFac=1.22:0.01:1.22;
    figure
    for k = 1:5 %SNR values, amount of lines
        xasDb = [xasDb; -2+k];
        legendInfo(k)=cellstr(['SNR = ' num2str(xasDb(k))]);
        for l = 1:length(xasFac)                                %aantal waardes van factor
            Detect(l,k) = 0;
            DSPparam.stFac = xasFac(l);                         % event > threshold * factor
            DSPparam.endFac = xasFac(l);                        % event end < threshold * endFactor
            for j = 1:50
                P(:,1,k) = noisegen(E, xasDb(k));
                [eventVec, peakMatrix, timeStamp] = avsdspmodule_multi(P(:,1,k), A, DSPparam);
                [detection(1,1,k), falsePos] = compare_multi(avsdata, eventdata, eventVec, peakMatrix, param);
                Detect(l,k)= Detect(l,k) + 0.01*(~isnan(detection(1,1,k).startdiff)*~isnan(detection(1,1,k).stopdiff));
                %freqdiff(k) = detection(1,1,k).freqdiff;
            end
        end
        hold on;
        plot(xasFac,Detect(:,k))
    end
xlabel('Factor')
ylabel('Detection rate')
legend(legendInfo)
%end