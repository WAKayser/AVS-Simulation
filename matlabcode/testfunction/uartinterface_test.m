clear; close all;

avsdata(:,:,1) = create_array(0, 50, 1, pi/2, 0);
eventdata(1) = struct('type','cosine','delay',0.25,'duration',.75,'amplitude',10, 'freq', 100, 'exty', 0,'extfs', 0, 'location', 5j);

E = eventgen_multi(eventdata, 1);
[Z, Pz] = transform_multi(eventdata, avsdata, E);
N = noisegen(Z, 100);
Pz = noisegen(Pz, 20);
[P, A] = avsreceiver_multi(N, Pz, avsdata);

%% This is only supported in newer versions 
%% anc can be commented out, as it only gets the comport
%getfield(instrhwinfo('serial'), 'SerialPorts')

%% most often this port is used
port = 'COM3';


%P = ones(1600,1);

result = uartinterface(P*2^5, port);

% subplot(211)
% plot(P)
% 
% subplot(212)
% plot(result);
