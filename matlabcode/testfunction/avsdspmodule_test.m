function D = avsdspmodule_test
%AVSDSPMODULE_TEST fill in the values needed to test the avsdspmodule
%   avsdspmodule_multi will return an 5array of detecteddata structs
avsdata(:,:,1) = create_array(0, 50, 2, pi, 0);
avsdata(:,:,2) = create_array(5000, 50, 2, 0, pi);

% eventdata(1) = struct('type','pulse','delay',0,'duration',1,'amplitude',1, 'freq', 0, 'location', 500+1000j);
eventdata(1) = struct('type','cosine','delay',0,'duration',1,'amplitude',1, 'freq', 400, 'exty', 0,'extfs', 0, 'location', -1000+800j);
% eventdata(3) = struct('type','cosine','delay',0,'duration',1,'amplitude',1, 'freq', 800, 'location', -1200+600j);
% eventdata(4) = struct('type','cosine','delay',0,'duration',1,'amplitude',1, 'freq', 1200, 'location', -300+1000j);
% eventdata(5) = struct('type','cosine','delay',0,'duration',1,'amplitude',1, 'freq', 1600, 'location', 400+1200j);
% eventdata(6) = struct('type','cosine','delay',0,'duration',1,'amplitude',1, 'freq', 2000, 'location', 900+700j);
% eventdata(7) = struct('type','cosine','delay',0,'duration',1,'amplitude',1, 'freq', 2400, 'location', -1100-600j);
% eventdata(8) = struct('type','cosine','delay',0,'duration',1,'amplitude',1, 'freq', 2800, 'location', -700+1000j);

E = eventgen_multi(eventdata, 1);
Z = transform_multi(eventdata, avsdata, E);
N = noisegen(Z, 200);
[P, A] = avsreceiver_multi(N, avsdata);
D = avsdspmodule_multi(P, A, avsdata)

% Show


end

