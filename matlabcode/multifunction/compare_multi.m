function [detection, falsePos]=compare_multi(avsdata, eventdata, eventVec, peakMatrix, param)
% this function is uesed to compare the data that multple dspmodules generate    

    for j = 1:size(avsdata, 3)
        for i = 1:size(avsdata, 2)
        	% Cells because matlab is not always nice
            PeakMatrix = cell2mat(peakMatrix(:,i,j));
            [detection(:,i,j), falsePos(i,j)] = compare(avsdata(:,i,j), eventdata, eventVec(:,i,j), PeakMatrix, param);
        end
    end
end
