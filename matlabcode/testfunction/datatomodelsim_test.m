clear; close all;

avsdata(:,:,1) = create_array(0, 50, 1, pi/2, 0);
eventdata(1) = struct('type','cosine','delay',0.25,'duration',0.1,'amplitude',5, 'freq', 125, 'exty', 0,'extfs', 0, 'location', 5j);

E = eventgen_multi(eventdata, 1);
[Z, Pz] = transform_multi(eventdata, avsdata, E);
N = noisegen(Z, 10);
Pz = noisegen(Pz, 5);
[P, A] = avsreceiver_multi(N, Pz, avsdata);

subplot(211);
savesimulateddata(P, A, '../testbenchfiles/testdata.dat');

system('vsim -do ../docodesvsim/runsim.do');

dingetje = readsimulateddata('../testbenchfiles/detected.dat');
subplot(212);
plot(dingetje(2,:) * 125);