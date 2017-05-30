function [Z, Pz] = loctransform(transvec, sourcesignal)
%LOCATIONTRANSFORM Transform signal from source to AVS data
%   transvorm is complex location 
%   sourcesignal is signal at source

    delay = floor(abs(transvec) / (343 / 272000));
    loss = abs(transvec) * 1; % simple aproximation of loss
    sigdelay = [zeros(floor(delay(1)/17), 1); sourcesignal(1:17:end-delay(1))] ./ loss';
    % Pz = sigdelay(1:17:end);
    Z = sigdelay * transvec / abs(transvec);
end
