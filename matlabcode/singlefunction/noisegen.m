function [ N ] = noisegen(Z, dB)
%NOISEGEN Create noise to overlay on the signal
%   Wrapper for AWGN matlab function
%   Can later be extended to create more advanced noise patterns
%   Clean signal will be a 3 dimensional matrix
%   The first dimension will be time
%   The second dimension will be the y and x components
%   the third dimension will be the index of the AVS
    N = awgn(Z, dB);
end

