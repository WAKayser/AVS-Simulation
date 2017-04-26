function [eventsignal] = eventgen(delay, duration, freq, amplitude, length)
%EVENTGEN generate different types of events
%   There are two types of event impulse and sinusoidal

samplerate = 272 * 1000;
t = 0:1/samplerate:duration;
cosine = amplitude * cos(2 * pi * t * freq);
before = zeros(1, delay * samplerate);
after = zeros(1, (length - delay - duration)*samplerate);
eventsignal = [before cosine after];
    
end
