function [Z, Pz] = loctransform(transvec, sourcesignal)
%LOCATIONTRANSFORM Transform signal from source to AVS data
%   transvorm is complex location 
%   sourcesignal is signal at source

    delay = floor(abs(transvec) / (343 / 272000));
    loss = abs(transvec) * 1; % simple aproximation of loss
    sigdelay = [zeros(delay, 1); sourcesignal(1:end-delay)] / loss;
    Pz = sigdelay(1:17:end);
    Z = Pz * transvec / abs(transvec);
end
