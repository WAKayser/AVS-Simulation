function [detection, falsePos]=compare(avsdata, eventdata, eventVec, peakVector, param)

    Fs = 16000;
    detectStart=[];
    detectStop=[];
    detectStart = (find (eventVec == 0.1))./Fs;
    detectStop = (find (eventVec == -0.1))./Fs;
    detectFreq = sort(peakVector);
    detection = [];
    falsePos.start = 0;
    falsePos.freq = 0;
    
for i = 1:length(eventdata(1,:))
    eventStart(i) = eventdata(1,i).delay + abs(eventdata(:,i).location-avsdata.location)/343;
    eventStop(i) = eventStart(i) + eventdata(1,i).duration;
    eventFreq(i) = eventdata(1,i).freq;
    
    detection(i).freqdiff = nan;
    detection(i).startdiff = nan;
    detection(i).stopdiff = nan;
    
    %%
    for j = 1:length(detectStart)
        if abs(eventStart(i) - detectStart(j)) < param.start
            %disp(['Event ' num2str(i) ' start detected'])
            detection(i).startdiff = eventStart(i) - detectStart(j);
            detectStart(j) = [];
            break;
        end
    end

    for j= 1:length(detectStop)
        if abs(eventStop(i) - detectStop(j)) < param.stop
            %disp(['Event ' num2str(i) ' stop detected'])
            detection(i).stopdiff = detectStop(j) - eventStop(i);
            detectStop(j) = [];
            break;
        end
    end
    for j = 1:length(detectFreq)
        if abs(eventFreq(i) - detectFreq(j)) < param.freq
            %disp(['Frequency ' num2str(detectFreq(j)) ' from event ' num2str(i) ' detected'])
           detection(i).freqdiff = eventFreq(i) - detectFreq(j);
           detectFreq(j) = [];
           break;
        end
    end
end 
    falsePos.start = length(detectStart);
    falsePos.freq = length(detectFreq);
end

    