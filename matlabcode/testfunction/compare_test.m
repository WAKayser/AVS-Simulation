%function compare_test
%%
%Create sensor data and AVS
Fs = 16000;
avsdata(:,:,1) = create_array(0, 0, 1, pi, 0);
avsdata(:,:,2) = create_array(10, 1, 1, 0, pi);
eventdata(1) = struct('type','cosine','delay',0.2,'duration',0.1,'amplitude',1, 'freq', 6000, 'location', 20);
eventdata(2) = struct('type','cosine','delay',0.7,'duration',0.15,'amplitude',1, 'freq', 394, 'location', 20);
eventdata(3) = struct('type','cosine','delay',0.4,'duration',0.2,'amplitude',1, 'freq', 3000, 'location', 15+15j);
E = eventgen_multi(eventdata, 1);
Z = transform_multi(eventdata, avsdata, E);
N = noisegen(Z, 55);
[P, A] = avsreceiver_multi(N, avsdata);

    %%
    %Give DSP parameters and detection margins
    DSPparam.long = 1000;                       % LTA parameter
    DSPparam.short = 200;                       % STA parameter
    DSPparam.stFac = 5;                         % event > threshold * factor
    DSPparam.endFac = 3;                        % event end < threshold * endFactor
    DSPparam.bwFac = 0.9;                       % used for BW estimates
    param.start = 3*DSPparam.short./Fs;                % Error margin on start time
    param.stop = 3*DSPparam.short./Fs;                 % Error margin on stop time
    param.freq = Fs/DSPparam.short;                 % Error margin on signal frequency
    
    %%
    %Get detection results
    [eventVec, peakMatrix, timeStamp] = avsdspmodule_multi(P, A, DSPparam);
    [detection, success] = compare_multi(avsdata, eventdata, eventVec, peakMatrix, param);
    
    %%
    %Plot detection results
    average = mean(success)
    Freq=[];
    Start=[];
    Stop=[];

    for j = 1:size(detection, 3)
        for i = 1:size(detection, 2)
            Freq=[Freq; detection(:,i,j).freqdiff]
            Start =[Start; detection(:,i,j).startdiff]
            Stop =[Stop; detection(:,i,j).stopdiff]
        end
    end
    
    subplot(221)
    tas = (1:size(P(:, 1, 1)))./Fs;     
    hold on;
    plot(tas,P(:,1,1))
    % eventVec filtering
    tas2 = (1:length(eventVec(:,1,1)))./Fs;     
    eventVec(eventVec(:,1,1)==0 ,1 ,1) = nan;
    plot(tas2,eventVec(:,1,1),'x')
    
    subplot(222)
    tas = (1:size(P(:, 1, 1)))./Fs;     
    hold on;
    plot(tas,P(:,1,2))
    % eventVec filtering
    tas2 = (1:length(eventVec(:,1,2)))./Fs;     
    eventVec(eventVec(:,1,2)==0,1,2) = nan ;
    plot(tas2,eventVec(:,1,2),'x')

    peakMatrix1 = cell2mat(peakMatrix(1));
    peakMatrix2 = cell2mat(peakMatrix(2));
    timeStamp1 = cell2mat(timeStamp(1));
    timeStamp2 = cell2mat(timeStamp(2));
   
    subplot(223)
    plot(timeStamp1, peakMatrix1(1:end,:,1,1));   
    
    subplot(224)
    plot(timeStamp2, peakMatrix2(1:end,:,1,1)); 
%end