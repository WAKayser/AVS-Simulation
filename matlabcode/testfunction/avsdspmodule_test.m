function D = avsdspmodule_test
%AVSDSPMODULE_TEST fill in the values needed to test the avsdspmodule
%   avsdspmodule_multi will return an 5array of detecteddata structs
avsdata(:,:,1) = create_array(0, 50, 2, pi, 0);
avsdata(:,:,2) = create_array(5000, 50, 2, 0, pi);

eventdata(1) = struct('type','pulse','delay',0.25,'duration',0.1,'amplitude',1, 'freq', 0, 'location', 500+200j);
eventdata(2) = struct('type','cosine','delay',0.5,'duration',0.1,'amplitude',1, 'freq', 2000, 'location', -1000+800j);

E = eventgen_multi(eventdata, 1);
Z = transform_multi(eventdata, avsdata, E);
N = noisegen(Z, 75);
[P, A] = avsreceiver_multi(N, avsdata);
D = avsdspmodule_multi(P, A, avsdata)

% Show


end

