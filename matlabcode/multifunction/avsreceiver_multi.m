function [pressure, A] = avsreceiver_multi(Z, Pz, avsdata)
%AVSRECEIVER_MULTI Summary of this function goes here
%   Detailed explanation goes here

	% Preallocate because of speed. 
    pressure = zeros(size(Z));
    A = zeros(size(Z));

    % calculate the avsreceiver data for all the different receivers. 
    for i = 1:size(avsdata, 2)
        for j = 1:size(avsdata, 3)
            [pressure(:,i,j), A(:,i,j)] = avsreceiver(Z(:,i,j), Pz(:,i,j), avsdata(:,i,j));
        end
    end
end

