function [Z] = locationtransform(transform, sourcesignal)
%LOCATIONTRANSFORM Transform signal from source to AVS data
%   Determine what the AVS will receive. 
%   transform vector is of form [x, y] and starts at AVS

    delay = floor(abs(transform) / 0.25);
    loss = abs(transform) * 1; % simple aproximation of loss
    sigdelay = [zeros(1, delay) sourcesignal(1:end-delay)] / loss;
    Z = sigdelay(1:17:end) * transform / abs(transform);
end
