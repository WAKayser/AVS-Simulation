    %%function false_positive_test
    %initialization
    %close all;
    clear all;
    Fs = 48000;
    %False positive test, 1 sec no events
    avsdata(:,:,1) = create_array(0, 0, 1, pi/2, 0); 
    eventdata(1) = struct('type','cosine','delay',10,'duration',0,'amplitude',0, 'freq', 0, 'location', 0);
    %E = zeros(2*Fs,1);
    A = 1;
    Fac = [];
    xasDb = [];
    Detect = [];
   
    %Give DSP parameters and detection margins
    DSPparam.Fs = Fs;
    DSPparam.long = Fs/2;                       % LTA parameter
    DSPparam.short = Fs/10;                       % STA parameter
    DSPparam.freqFac = 20;                       % used for detecting peaks
    param.start = 200./Fs;         % Error margin on start time
    param.stop = 200./Fs;          % Error margin on stop time
    param.freq = Fs/DSPparam.short;             % Error margin on signal frequency
    param.Fs = DSPparam.Fs;
    
    %%
    %False pos - factor
    Fac=1.28:0.01:1.33;
    Trig = 500:500:3000;
    figure
        for l = 1:length(Fac)                                %aantal waardes van factor
            Detect(l) = 0;
            DSPparam.stFac = Fac(l);                         % event > threshold * factor
            DSPparam.endFac = Fac(l);                        % event end < threshold * endFactor
            for k = 1:length(Trig);
                DSPparam.trig = Trig(k); 
                for j = 1
                    E = zeros(1000*Fs,1);
                    P(:,1,k) = noisegen(E, 0, 2);
                    [eventVec, peakMatrix, peakVector] = avsdspmodule_multi(P(:,1,k), A, DSPparam);
                    [detection(1,1,k), falsePos] = compare_multi(avsdata, eventdata, eventVec, peakMatrix, param);
                    FP(j,l,k) = falsePos.start;                
                end
                plotFP(l,k) = mean(FP(:,l,k));
                
            end
        %hold on;
        %plot(xasFac,plotFP)
        end
        surf(Trig,Fac,plotFP)
xlabel('Trigger number')
ylabel('Factor')

%     %%
%     %False pos - Trigger number
%     DSPparam.stFac = 1.25;                         % event > threshold * factor
%     DSPparam.endFac = 1.25;     
%     Trig =1:500:2501;
%     figure
%           for l = 1:length(Trig)                               
%             Detect(l) = 0;
%             DSPparam.trig = Trig(l);                         % event > threshold * factor
%             for j = 1:100
%                 P(:,1) = noisegen(E, 0, 2);
%                 [eventVec, peakMatrix, peakVector] = avsdspmodule_multi(P(:,1), A, DSPparam);
%                 [detection(1,1), falsePos] = compare_multi(avsdata, eventdata, eventVec, peakMatrix, param);
%                 FP(j,l) = falsePos.start;                
%             end
%             plotFP(l) = mean(FP(:,l));
%         end
%         hold on;
%         plot(Trig,plotFP)
%     xlabel('Trigger number')
%     ylabel('False positives')
% %end