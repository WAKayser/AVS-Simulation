function [eventsignal] = eventgen(delay, duration, freq, length)
%EVENTGEN generate different types of events
%   There are two types of event impulse and sinusoidal

if delay + duration > length
    ME = MException('eventgen:signaltooshort', ...
        'Please increase your global signal length',str);
    throw(ME)
end

samplerate = 340 * 100;
t = 0:1/samplerate:duration;
cosine = cos(2 * pi * t * freq);
before = zeros(1, delay * samplerate);
after = zeros(1, (length - delay - duration)*samplerate);
eventsignal = [before cosine after];
    
end

