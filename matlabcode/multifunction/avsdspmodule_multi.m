function [detected] = avsdspmodule_multi(P, A, avsdata)
%AVSDSPMODULE_MULTI Summary of this function goes here
%   Detailed explanation goes here
    for i = 1:size(P, 2)
        for j = 1:size(P, 3)
            detected(1,i,j) = avsdspmodule(P(:,i,j), A(:,i,j), avsdata(:,i,j));
        end
    end
end

