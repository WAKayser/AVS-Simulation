function [pressure, A] = avsreceiver_multi(Z, avsdata)
%AVSRECEIVER_MULTI Summary of this function goes here
%   Detailed explanation goes here

    pressure = zeros(size(Z));
    A = zeros(size(Z));

    for i = 1:size(avsdata, 2)
        for j = 1:size(avsdata, 3)
            [pressure(:,i,j), A(:,i,j)] = avsreceiver(Z(:,i,j), avsdata(:,i,j));
        end
    end
end

