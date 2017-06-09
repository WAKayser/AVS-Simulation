function [peakMatrix, peakVector] = peakUpdate(peakMatrix, peakVector, peaks, time)
% This function is used to split all the estimated frequencies into their own 
    % eventcolumns. 
    
    % Create another empty row
    for i = 1:length(peaks)
        % find if it is already in the matrix
        index = find(peakVector==peaks(i));
        % Add it to the same column
        if index
            peakMatrix(time, index) = peaks(i);
        else %nieuwe colum en nieuwe entry in vector, 
            peakVector(end+1) = peaks(i);
            peakMatrix(time, length(peakVector)) = peaks(i);
        end
    end
end
