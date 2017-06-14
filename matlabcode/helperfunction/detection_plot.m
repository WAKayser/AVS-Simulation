function detection_plot(detection, eventVec, peakMatrix, P)
    Freq=[];
    Start=[];
    Stop=[];
    Fs = 48000;
    
    for j = 1:size(detection, 3)
        for i = 1:size(detection, 2)
            Freq=[Freq; detection(:,i,j).freqdiff]
            Start =[Start; detection(:,i,j).startdiff]
            Stop =[Stop; detection(:,i,j).stopdiff]
            %StartSample(:,i,j) = find(eventVec(:,i,j) == 0.1);
            %StopSample(:,i,j) = find(eventVec(:,i,j) == -0.1);
        end
    end
    
    PM=[];
    
     for j = 1:size(detection, 3)
        for i = 1:size(detection, 2)
            figure
            subplot(211)
            tas = (1:size(P(:, i, j)))./Fs;     
            hold on;
            plot(tas(1:10:end),P(1:10:end,i,j));
            tas2 = (1:length(eventVec(:,i,j)))./Fs;     
            eventVec(eventVec(:,i,j)==0 ,i ,j) = nan;
            eventVec(eventVec(:,i,j)==0.1 ,i ,j) = 0.01;
            eventVec(eventVec(:,i,j)==-0.1 ,i ,j) = -0.01;
            plot(tas2(1:1:end),eventVec(1:1:end,i,j),'x') 
            
            %Plot 2
            PM = cell2mat(peakMatrix(1,i,j));
            subplot(212)
            TS = (1:size(PM, 1)) ./ Fs;
            plot(TS(1:10:end), PM(1:10:end,:,1));   
        end
     end
end