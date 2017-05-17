function eventgen_test
    load train.mat;

    eventdata(1) = struct('type','pulse','delay',0.25,'duration',0.1,'amplitude',1, 'freq', 0, 'exty', 0,'extfs', 0, 'up', 0.025, 'down', 0.025, 'location', 500+200j);
    eventdata(2) = struct('type','cosine','delay',0.5,'duration',0.1,'amplitude',1, 'freq', 20, 'exty', 0,'extfs', 0, 'up', 0.025, 'down', 0.025, 'location', 2000+800j);
    eventdata(3) = struct('type','whitenoise','delay',0.5,'duration',0.1,'amplitude',1, 'freq', 20, 'exty', 0,'extfs', 0, 'up', 0.05, 'down', 0, 'location', 2000+800j);
    eventdata(4) = struct('type','external','delay',0.5,'duration',0.1,'amplitude',1, 'freq', 20, 'exty', y,'extfs', Fs, 'up', 0, 'down', 0, 'location', 2000+800j);

    event_wave = eventgen_multi(eventdata, 4);
    
    for i = 1:4
        subplot(2, 2, i);
        plot(event_wave(:, i))
    end
end
