
close all;
clear all;
Fs = 16000;
%AVSdata for signal detection
avsdata(:,:,1) = create_array(0, 0, 1, pi/2, 0);     %start, step, number, orientation, change
eventdata(1) = struct('type','cosine','delay',0.2,'duration',1,'amplitude', sqrt(2), 'freq', 1000, 'location', 0);
E = eventgen_multi(eventdata, 1.3);
E = E(1:17:end,:,:);
A = 1;
xasFac = [];
xasdB = [];
Detect = [];

    DSPparam.short = 400;                       % STA parameter
    DSPparam.long = 5*DSPparam.short;           % LTA parameter
    DSPparam.trig = 1;                          % Trigger number    
    DSPparam.stFac = 1.22;                      % event > threshold * factor
    DSPparam.endFac = 1.22;
    param.start = DSPparam.short./Fs;           % Error margin on start time
    param.stop = DSPparam.short./Fs;            % Error margin on stop time
    param.freq = 1.5*Fs/DSPparam.short;         % Error margin on signal frequency
    

    figure
    for k = 1:1 %SNR values, amount of lines
        xasdB = [xasdB; -2*k];
        legendInfo(k)=cellstr(['SNR = ' num2str(xasdB(k))]);
        for l = 1:2 
            x(l) = 3.9+0.1*l;
            DSPparam.freqFac = x(l); %aantal waardes van factor
            Detect(l,k) = 0;
            for j = 1:1000
                P(:,1,k) = noisegen(E, xasdB(k));
                [eventVec, peakMatrix, timeStamp] = avsdspmodule_multi(P(:,1,k), A, DSPparam);
                [detection(1,1,k), falsePos] = compare_multi(avsdata, eventdata, eventVec, peakMatrix, param);
                Freq(j,l,k) = (falsePos.freq-1);    
            end
            plotFreq(l,k) = mean(Freq(:,l,k));
        end
        hold on;
        plot(x,plotFreq(:,k))
    end
xlabel('Factor')
ylabel('False positives')
legend(legendInfo)