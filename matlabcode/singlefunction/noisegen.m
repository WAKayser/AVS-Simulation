function [ N ] = noisegen(Z, dB, version)
%NOISEGEN Create noise to overlay on the signal
%   Wrapper for AWGN matlab function
%   Can later be extended to create more advanced noise patterns
%   Clean signal will be a 3 dimensional matrix
%   The first dimension will be time
%   The second dimension will be the y and x components
%   the third dimension will be the index of the AVS

%	Should we extend the simulation to take into account correlated noise?
    noisecolor = load('noisecolor.mat');
    noisecolor = noisecolor.noisecolor;

    if nargin == 2
        version = 1;
        'Please update your noisegen call to include version number (1 or 2)'
    end
    
    N = zeros(size(Z));
    for i = 1:size(Z, 2)
        for j = 1:size(Z, 3)
            if version == 2 % measurement and pink noise based noise
                if isreal(Z)
                    mode = 'real';
                else
                    mode = 'complex';
                end
                N(:,i,j) = Z(:,i,j) + filter(noisecolor, wgn(size(Z, 1), 1, -dB, 1, mode, 'dBW'));
            elseif version == 1 % Plain white noise
                N(:,i,j) = awgn(Z(:,i,j), dB);
            end
        end
    end
end

