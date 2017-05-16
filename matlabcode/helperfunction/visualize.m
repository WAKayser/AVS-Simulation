function visualize(inputArray, Fs, plotSize, sampleSize, eventVec, midFreqEst, bwEst, peakMatrix)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    % data plots
     subplot(4,1,1)
     FTplot(inputArray(1:plotSize),Fs,plotSize/sampleSize);
     ylim([0 Fs/2])
     set(gca,'Ydir','Normal')

     subplot(4,1,2)
     plot(peakMatrix)

     subplot(4,1,3)
     plot(bwEst)

     subplot(4,1,4)
     tas = (1:plotSize)./Fs;     
     plot(tas,inputArray(1:plotSize))

     hold on

     % eventVec filtering
     tas2 = (1:length(eventVec))./Fs;     
     eventVec(eventVec==0) = nan ;

     subplot(4,1,4)
     plot(tas2,eventVec,'x')


end

