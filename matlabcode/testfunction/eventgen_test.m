function eventgen_test
    eventdata(1) = struct('type','pulse','delay',0.25,'duration',0.1,'amplitude',1, 'freq', 0, 'location', 500+200j);
    eventdata(2) = struct('type','cosine','delay',0.5,'duration',0.1,'amplitude',1, 'freq', 20, 'location', 2000+800j);
    event_wave = eventgen_multi(eventdata, 1);
    
    subplot(2, 1, 1);
    plot(event_wave(:, 1))
    
    subplot(2, 1, 2);
    plot(event_wave(:, 2))
end
