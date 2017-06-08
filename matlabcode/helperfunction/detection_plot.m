function detection_plot(detection, eventVec, peakMatrix, timeStamp, P)
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
    TS=[];
    
     for j = 1:size(detection, 3)
        for i = 1:size(detection, 2)
            figure
            subplot(211)
            tas = (1:size(P(:, i, j)))./Fs;     
            hold on;
            plot(tas,P(:,i,j));
            tas2 = (1:length(eventVec(:,i,j)))./Fs;     
            eventVec(eventVec(:,i,j)==0 ,i ,j) = nan;
            eventVec(eventVec(:,i,j)==0.1 ,i ,j) = 0.01;
            eventVec(eventVec(:,i,j)==-0.1 ,i ,j) = -0.01;
            plot(tas2,eventVec(:,i,j),'x') 
            
            %Plot 2
            PM = cell2mat(peakMatrix(1,i,j));
            TS = cell2mat(timeStamp(1,i,j));
            subplot(212)
            plot(TS, PM(1:end,:,1));   
        end
     end
end