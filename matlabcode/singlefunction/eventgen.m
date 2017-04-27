function [eventsignal] = eventgen(eventdata, length)
%EVENTGEN generate different types of events
%   There are two types of event impulse and sinusoidal
    samplerate = 272 * 1000;
    
    if strcmp(eventdata.type, 'cosine')
        t = 1/samplerate:1/samplerate:eventdata.duration;
        signal = eventdata.amplitude * cos(2 * pi * t * eventdata.freq);
    elseif strcmp(eventdata.type, 'pulse')
        signal = eventdata.amplitude * ones(1, eventdata.duration*samplerate);
    end
    before = zeros(1, eventdata.delay * samplerate);
    after = zeros(1, ((length - eventdata.delay - eventdata.duration)*samplerate));
    eventsignal = [before signal after];
end
