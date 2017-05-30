clear; close all;

avsdata(:,:,1) = create_array(0, 50, 1, pi/2, 0);
eventdata(1) = struct('type','cosine','delay',0.25,'duration',0.1,'amplitude',5, 'freq', 125, 'exty', 0,'extfs', 0, 'location', 5j);

E = eventgen_multi(eventdata, 1);
[Z, Pz] = transform_multi(eventdata, avsdata, E);
N = noisegen(Z, 100);
Pz = noisegen(Pz, 20);
[P, A] = avsreceiver_multi(N, Pz, avsdata);

getfield(instrhwinfo('serial'), 'SerialPorts')

port = 'COM3';

result = uartinterface(P, port);

subplot(211)
plot(P)

subplot(212)
plot(result);
