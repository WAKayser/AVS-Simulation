function [eventsignal] = eventgen(eventdata, duration)
%EVENTGEN generate different types of events
%   There are two types of event impulse and sinusoidal
    samplerate = 272 * 1000;
    
    %% What type of event will be simulated
    if strcmp(eventdata.type, 'cosine')
        % this generates a cosine wave, best used with up/down
        t = 1/samplerate:1/samplerate:eventdata.duration;
        signal = eventdata.amplitude * cos(2 * pi * t * eventdata.freq);
    elseif strcmp(eventdata.type, 'pulse')
        % This can be used to generate a basic pulse
        signal = linspace(0,-1,samplerate*eventdata.duration / 4);
        signal = [signal linspace(-1,1,samplerate*eventdata.duration / 2)];
        signal = [signal linspace(1,0,samplerate*eventdata.duration / 4)];
    elseif strcmp(eventdata.type, 'whitenoise')
        % this create a whitenoise source
        signal = wgn(1, eventdata.duration*samplerate, 10 * log10(eventdata.amplitude));
    elseif strcmp(eventdata.type, 'external')
        % THis can be used to load any other music sources. 
        signal = (eventdata.amplitude * resample(eventdata.exty, samplerate, eventdata.extfs))';
    elseif strcmp(eventdata.type, 'variable')
        % this can be used to make variable sinusoidal sources
        % later maybe to simulate doppler?
        t = 1/samplerate:1/samplerate:eventdata.duration;
        signal = eventdata.amplitude * cos(2 * pi * t .* (eventdata.freq + eventdata.change * t));
    end
    
    %% Windowing %
    % Now are they linear, will they be more complex later>
    modifier = ones(size(signal));
    % Create ramp upp
    if isfield(eventdata, 'up')
        modifier(1:eventdata.up*samplerate) = linspace(0,1,eventdata.up*samplerate);
    end
    
    %create ramp down
    if isfield(eventdata, 'down')
        modifier(end-eventdata.down*samplerate+ 1:end) = linspace(1,0,eventdata.down*samplerate);
    end
    
    %% Create delays
    before = zeros(1, eventdata.delay * samplerate);
    after = zeros(1, (duration *samplerate) - length(before) - length(signal));
    eventsignal = [before signal.*modifier after];
end
