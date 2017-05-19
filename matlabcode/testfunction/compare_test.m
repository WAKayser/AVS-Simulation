clear
Fs = 16000;
avsdata(:,:,1) = create_array(0, 0, 2, pi, 0);
avsdata(:,:,2) = create_array(10, 1, 2, 0, pi);
eventdata(1) = struct('type','cosine','delay',0.2,'duration',0.1,'amplitude',1, 'freq', 6000, 'location', 20);
eventdata(2) = struct('type','cosine','delay',0.7,'duration',0.15,'amplitude',1, 'freq', 394, 'location', 20);
eventdata(3) = struct('type','cosine','delay',0.4,'duration',0.2,'amplitude',1, 'freq', 3000, 'location', 15+15j);

E = eventgen_multi(eventdata, 1);
Z = transform_multi(eventdata, avsdata, E);
N = noisegen(Z, 55);
[P, A] = avsreceiver_multi(N, avsdata);
param.start = 0.025;
param.stop = 0.025;
param.freq = 80;
    
[eventVec, peakMatrix, timeStamp] = avsdspmodule_multi(P, A);

[detection, success] = compare_multi(avsdata, eventdata, eventVec, peakMatrix, param)

average = mean(success)
