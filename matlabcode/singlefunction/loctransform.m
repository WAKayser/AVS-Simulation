function [Z, Pz] = loctransform(transvec, sourcesignal)
%LOCATIONTRANSFORM Transform signal from source to AVS data
%   transvorm is complex location 
%   sourcesignal is signal at source

	% Calculate the delay that is on the signal
    delay = floor(abs(transvec) / (343 / 16000));
    % determine the loss vector, could be way more complex
    loss = abs(transvec) * 1;
    % delay the signal, this is also a bit lazy, as it does not cut the end when needed
    sigdelay = [zeros(delay, 1); sourcesignal(1:17:end-delay)];
    % downsample the signal and apply the loss factor
    Pz = sigdelay / loss;
    % Determine the assiciated 
    Z = Pz * transvec / abs(transvec);
end
