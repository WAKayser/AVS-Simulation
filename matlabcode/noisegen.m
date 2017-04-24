function [ noisesignal ] = noisegen(cleansignal, dB)
%NOISEGEN Create noise to overlay on the signal
%   Wrapper for AWGN matlab function
%   Can later be extended to create more advanced noise patterns
%   Clean signal will be a 3 dimensional matrix
%   The first dimension will be time
%   The second dimension will be the y and x components
%   the third dimension will be the index of the AVS
    
    avsnum = size(cleansignal, 3);
    noisesignal = zeros(size(cleansignal));
    for avs = 1:avsnum
        for channel = 1:2
            noisesignal(:,channel,avs) = awgn(cleansignal(:,channel, avs), dB);
        end
    end
end

