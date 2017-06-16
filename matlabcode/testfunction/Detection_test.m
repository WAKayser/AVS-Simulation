%function Detection_test
%%
close all;
clear all;
Fs = 48000;
%AVSdata for signal detection
avsdata(:,:,1) = create_array(0, 0, 1, pi/2, 0);     %start, step, number, orientation, change
eventdata(1) = struct('type','cosine','delay',1,'duration',0.5,'amplitude', sqrt(2), 'freq', 5000, 'location', 0);
E = eventgen_multi(eventdata, 2);
E = E(1:17:end,:,:);
A = 1;
Detect = [];
%%
%Parameters to be optimized
    DSPparam.Fs = Fs;
    DSPparam.long = Fs/2;                       % LTA parameter
    DSPparam.short = Fs/10;                       % STA parameter
    DSPparam.trig = 2500;                          % Trigger number
    DSPparam.freqFac = 20;                       % used for detecting peaks
    param.start = (DSPparam.short)/Fs;         % Error margin on start time
    param.stop = (DSPparam.short)/Fs;          % Error margin on stop time
    param.freq = Fs/DSPparam.short;             % Error margin on signal frequency
    param.Fs = Fs;
    
    
    %%
    %
    SNR = -1:0.5:1;
    Fac=1.28:0.01:1.33;
    Detect = zeros(length(Fac),length(SNR));
    figure
    for k = 1:length(SNR) %SNR values, length of x-axis
  
        for l = 1:length(Fac)
          
            DSPparam.stFac = Fac(l);                         % event > threshold * factor
          	DSPparam.endFac = Fac(l);                        % event end < threshold * endFactor
            for j = 1:100
                P = noisegen(E, SNR(k),2);
                [eventVec, ~, peakVector] = avsdspmodule(P, A, DSPparam);
                [detection, falsePos] = compare(avsdata, eventdata, eventVec, cell2mat(peakVector), param);
                temp(j)= (~isnan(detection.startdiff)*~isnan(detection.stopdiff));
            end
            Detect(l,k) = mean(temp);
        end
    end
    surf(SNR,Fac,Detect)
    xlabel('SNR')
    ylabel('Factor')
    %legend(legendInfo)

%%
% Oude versie met meerdere factors
%     xasFac=1.22:0.01:1.22;
%     figure
%     for k = 1:5 %SNR values, amount of lines
%         xasDb = [xasDb; -2+k];
%         legendInfo(k)=cellstr(['SNR = ' num2str(xasDb(k))]);
%         for l = 1:length(xasFac)                                %aantal waardes van factor
%             Detect(l,k) = 0;
%             DSPparam.stFac = xasFac(l);                         % event > threshold * factor
%             DSPparam.endFac = xasFac(l);                        % event end < threshold * endFactor
%             for j = 1:50
%                 P(:,1,k) = noisegen(E, xasDb(k));
%                 [eventVec, peakMatrix, timeStamp] = avsdspmodule_multi(P(:,1,k), A, DSPparam);
%                 [detection(1,1,k), falsePos] = compare_multi(avsdata, eventdata, eventVec, peakMatrix, param);
%                 Detect(l,k)= Detect(l,k) + 0.01*(~isnan(detection(1,1,k).startdiff)*~isnan(detection(1,1,k).stopdiff));
%                 %freqdiff(k) = detection(1,1,k).freqdiff;
%             end
%         end
%         hold on;
%         plot(xasFac,Detect(:,k))
%     end
% xlabel('Factor')
% ylabel('Detection rate')
% legend(legendInfo)

%end