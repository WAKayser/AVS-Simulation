function [pressure, A] = avsreceiver(Z, rotation, bitdepth, scale)
%AVSRECEIVER takes the complex_signals and computes the value returned by
%   the AVS,
%This will be implemented very simply, but should be extended for the 
%   particular sensor. 
    R = Z * exp(-1j*rotation);
    A = round(R, ceil(log10(2^bitdepth)));
    pressure = scale * (real(A) + imag(A));
end

