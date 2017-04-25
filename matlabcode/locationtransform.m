function [Zx, Zy] = locationtransform(transvec, sourcesignal)
%LOCATIONTRANSFORM Transform signal from source to AVS data
%   Determine what the AVS will receive. 
%   transform vector is of form [x, y] and starts at AVS

delay = floor(norm(transvec) / 0.25);

loss = norm(transvec) * 1; % simple aproximation of loss

sigdelay = [zeros(1, delay) sourcesignal(1:end-delay)] / loss;

Zx = sigdelay(1:17:end) * transvec(1)^2 / norm(transvec)^2;
Zy = sigdelay(1:17:end) * transvec(2)^2 / norm(transvec)^2;
end

