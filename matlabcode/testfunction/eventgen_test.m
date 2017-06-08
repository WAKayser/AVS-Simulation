clear all;
load train.mat;

eventdata(1) = struct('type','pulse','delay',0.25,'duration',0.1,'amplitude',1, 'freq', 0, 'change', 200, 'exty', 0,'extfs', 0, 'up', 0, 'down', 0, 'location', 5);
eventdata(2) = struct('type','cosine','delay',0.5,'duration',0.1,'amplitude',1, 'freq', 20, 'change', 200,  'exty', 0,'extfs', 0, 'up', 0.025, 'down', 0.025, 'location', 5);
eventdata(3) = struct('type','whitenoise','delay',0.5,'duration',0.1,'amplitude',1, 'freq', 20, 'change', 200,  'exty', 0,'extfs', 0, 'up', 0.05, 'down', 0, 'location', 5);
eventdata(4) = struct('type','external','delay',0.5,'duration',0.1,'amplitude',1, 'freq', 20, 'change', 200,  'exty', y,'extfs', Fs, 'up', 0, 'down', 0, 'location', 5);
eventdata(5) = struct('type','variable','delay',0.1,'duration',0.8,'amplitude',1, 'freq', 10, 'change', 20,  'exty', y,'extfs', Fs, 'up', 0, 'down', 0, 'location', 5);

event_wave = eventgen_multi(eventdata, 4);

for i = 1:5
    subplot(3, 2, i);
    plot(event_wave(:, i))
end
