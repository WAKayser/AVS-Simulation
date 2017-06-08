%function false_positive_test

close all;
clear all;
Fs = 16000;
%False positive test, 1 sec no events
avsdata(:,:,1) = create_array(0, 0, 1, pi/2, 0); 
eventdata(1) = struct('type','cosine','delay',0,'duration',0,'amplitude',0, 'freq', 0, 'location', 0);
E = zeros(Fs,1);
A = 1;
xasFac = [];
xasDb = [];
Detect = [];
%%
%Parameters to be optimized
    DSPparam.short = 400;                       % STA parameter
    DSPparam.long = 5*DSPparam.short;           % LTA parameter
    DSPparam.trig = 1;                          % Trigger number
    DSPparam.freqFac = 5;
    param.start = DSPparam.short./Fs;           % Error margin on start time
    param.stop = DSPparam.short./Fs;            % Error margin on stop time
    param.freq = 1.5*Fs/DSPparam.short;         % Error margin on signal frequency
    
    xasFac=1.18:0.01:1.22;
    figure
    for k = 1:1 %SNR values, amount of lines
        xasDb = [xasDb; k-1];
        %legendInfo(k)=cellstr(['SNR = ' num2str(xasDb(k))]);
        for l = 1:length(xasFac)                                %aantal waardes van factor
            Detect(l,k) = 0;
            DSPparam.stFac = xasFac(l);                         % event > threshold * factor
            DSPparam.endFac = xasFac(l);                        % event end < threshold * endFactor
            for j = 1:100
                P(:,1,k) = noisegen(E, xasDb(k));
                [eventVec, peakMatrix, timeStamp] = avsdspmodule_multi(P(:,1,k), A, DSPparam);
                [detection(1,1,k), falsePos] = compare_multi(avsdata, eventdata, eventVec, peakMatrix, param);
                FP(j,l,k) = falsePos.start;                
            end
            plotFP(l,k) = mean(FP(:,l,k));
        end
        hold on;
        plot(xasFac,plotFP(:,k))
    end
xlabel('Factor')
ylabel('False positives')
%end