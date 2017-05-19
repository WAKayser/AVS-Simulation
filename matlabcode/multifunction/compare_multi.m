function [detection, succescount]=compare_multi(avsdata, eventdata, eventVec, peakMatrix, param)
     for i = 1:size(avsdata, 2)
        for j = 1:size(avsdata, 3)
            [detection(:,i,j), succescount(i,j)] = compare(avsdata(:,i,j), eventdata, eventVec, peakMatrix, param);
        end
    end
end
