function [pressure, A] = avsreceiver(Z, avsdata)
%AVSRECEIVER takes the complex_signals and computes the value returned by
%   the AVS,
%This will be implemented very simply, but should be extended for the 
%   particular sensor. 
    R = Z * exp(-1j*avsdata.orientation);
    A = round(R * avsdata.scalevec, ceil(log10(2^avsdata.bitdepth)));
    pressure = avsdata.scalepres * (real(A) + imag(A)) / avsdata.scalevec;
end

