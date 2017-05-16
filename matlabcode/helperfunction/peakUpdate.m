function [peakMatrix, peakVector] = peakUpdate(peakMatrix, peakVector, peaks)


        lastRow = length(peakMatrix(:,end));

        for i = 1:length(peaks)
            for j = 1:length(peakVector)
                if peaks(i) == peakVector(j)
                    peakMatrix(lastRow + 1, j) = peaks(i);
                    break
                elseif j == length(peakVector)
                    peakVector(j) = peaks(i);
                    peakVector(j+1) = 0;
                end
            end
        end
        
end