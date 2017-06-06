function [peakMatrix, peakVector] = peakUpdate(peakMatrix, peakVector, peaks)
% This function is used to split all the estimated frequencies into their own 
    % eventcolumns. 

    % Create another empty row
    peakMatrix(end + 1, 1) = 0;
    for i = 1:size(peaks)
        % find if it is already in the matrix
        index = find(peakVector==peaks(i));
        % Add it to the same column
        if index
            peakMatrix(end, index) = peaks(i);
        else %nieuwe colum en nieuwe entry in vector, 
            peakVector(end+1) = peaks(i);
            peakMatrix(end, length(peakVector)) = peaks(i);
        end
    end
end
