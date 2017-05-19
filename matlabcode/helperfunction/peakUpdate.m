function [peakMatrix, peakVector] = peakUpdate(peakMatrix, peakVector, peaks)
    peakMatrix(end + 1, 1) = 0;
    for i = 1:length(peaks)
        index = find(peakVector==peaks(i))
        if index
            peakMatrix(end, index) = peaks(i)
            test = 'dit doet hij vaker'
        else %toevoegen aan peakVector
            peakVector(end+1) = peaks(i)
            peakMatrix(end, length(peakVector)) = peaks(i)
            test = 'dit doet hij een keer'
        end
    end
end
