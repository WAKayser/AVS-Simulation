function [pressure, A] = avsreceiver(Z, Pz, avsdata)
%AVSRECEIVER takes the complex_signals and computes the value returned by
%   the AVS,
%This will be implemented very simply, but should be extended for the 
%   particular sensor. 
	% Rotate the signal to take sensor rotation into account. 
    R = Z * exp(-1j*avsdata.orientation);
    % A Very lazy approach to simulate bitdepth
    A = round(R, ceil(log10(2^avsdata.bitdepth)));
    % Do the same with the pressure. 
    pressure = round(avsdata.scalepres * Pz, ceil(log10(2^avsdata.bitdepth)));
    % Scale the avsdata to simulate the sensor better
    % 420 is the acoustic impedance of air. 
    A = A * avsdata.scalevec / 420;
end

