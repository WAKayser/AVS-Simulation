function [detection, succescount]=compare_multi(avsdata, eventdata, eventVec, peakMatrix, param)
     for j = 1:size(avsdata, 3)
        for i = 1:size(avsdata, 2)
            PeakMatrix = cell2mat(peakMatrix(:,i,j));
            [detection(:,i,j), succescount(i,j)] = compare(avsdata(:,i,j), eventdata, eventVec(:,i,j), PeakMatrix, param);
        end
    end
end
