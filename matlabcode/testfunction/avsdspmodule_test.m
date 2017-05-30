function avsdspmodule_test
    %AVSDSPMODULE_TEST fill in the values needed to test the avsdspmodule
    %avsdspmodule_multi will return an array of detected data structs
    %Enter the system parameters
    Fs = 16000;
    
    longSize = 1000;                       % LTA parameter
    shortSize = 200;                       % STA parameter
    startFactor = 5;                       % event > threshold * factor
    endFactor = 3;                         % event end < threshold * endFactor
    bwFactor = 0.9;                        % used for BW estimates
    
    %%
    %Create AVS arrays and their measured data
    avsdata(:,:,1) = create_array(0, 0, 1, pi, 0);
    % avsdata(:,:,2) = create_array(10, 1, 1, 0, pi);
    eventdata(1) = struct('type','cosine','delay',0.2,'duration',0.1,'amplitude',20, 'freq', 1000, 'location', 20);
    % eventdata(2) = struct('type','cosine','delay',0.7,'duration',0.15,'amplitude',1, 'freq', 394, 'location', 20);
    % eventdata(3) = struct('type','cosine','delay',0.4,'duration',0.2,'amplitude',1, 'freq', 3000, 'location', 15+15j);
    E = eventgen_multi(eventdata, 1);
    [Z, Pz] = transform_multi(eventdata, avsdata, E);
    N = noisegen(Z, 100);
    Pz = noisegen(Pz, 15);
    [P, A] = avsreceiver_multi(N, Pz, avsdata);
    
    %%
    %Apply DSP to the AVS data
    DSPparam.long = longSize;
    DSPparam.short = shortSize;
    DSPparam.stFac = startFactor;
    DSPparam.endFac = endFactor;
    DSPparam.bwFac = bwFactor;
    [eventVec, peakMatrix, timeStamp] = avsdspmodule_multi(P, A, DSPparam);
    
    
    %%
    %Plot data
    subplot(221)
    tas = (1:size(P(:, 1, 1)))./Fs;     
    hold on;
    plot(tas,P(:,1,1))
    % eventVec filtering
    tas2 = (1:length(eventVec(:,1,1)))./Fs;     
    eventVec(eventVec(:,1,1)==0 ,1 ,1) = nan;
    plot(tas2,eventVec(:,1,1),'x')
    
%     subplot(222)
%     tas = (1:size(P(:, 1, 1)))./Fs;     
%     hold on;
%     plot(tas,P(:,1,2))
%     % eventVec filtering
%     tas2 = (1:length(eventVec(:,1,2)))./Fs;     
%     eventVec(eventVec(:,1,2)==0,1,2) = nan;
%     plot(tas2,eventVec(:,1,2),'x')

    peakMatrix1 = cell2mat(peakMatrix(1));
%     peakMatrix2 = cell2mat(peakMatrix(2));
    timeStamp1 = cell2mat(timeStamp(1));
%     timeStamp2 = cell2mat(timeStamp(2));
   
    subplot(223)
    plot(timeStamp1, peakMatrix1(1:end,:,1,1));   
    
    subplot(224)
%     plot(timeStamp2, peakMatrix2(1:end,:,1,1));  
end

