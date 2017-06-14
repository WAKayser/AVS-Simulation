function [eventwave] = eventgen_multi(eventdata, length)
%EVENTGEN_MULTI This can be used to set up multiple events
%   The total length of all events are based on 
    eventwave = zeros(floor(length * 272 * 1000 * 3), size(eventdata, 2));
    for i = 1:size(eventdata, 2)
        eventwave(:,i) = eventgen(eventdata(i), length);
    end
end

