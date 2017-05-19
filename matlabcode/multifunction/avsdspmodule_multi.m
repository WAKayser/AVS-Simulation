function [eventVec, peakMatrix, timeStamp] = avsdspmodule_multi(P, A)
%AVSDSPMODULE_MULTI Summary of this function goes here
%   Detailed explanation goes here
    
    for i = 1:size(P, 2)
        for j = 1:size(P, 3)
            

    [a, b, c] = avsdspmodule(P(:,i,j), A(:,i,j));
    
    a= size(a)
    b= size(b)
    c= size(c)
            [eventVec(:,i,j), peakMatrix(:,:,i,j), timeStamp(:,i,j)] = avsdspmodule(P(:,i,j), A(:,i,j));
        end
    end
end

