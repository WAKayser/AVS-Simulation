%AVSRECEIVER_TEST Summary of this function goes here
%   Detailed explanation goes here

clear
close
avsdata(:,:) = create_array(0, 5, 2, pi, 0);
%avsdata(:,:,2) = create_array(10, 1, 2, 0, pi);

eventdata(1) = struct('type','pulse','delay',0.25,'duration',0.1,'amplitude',1, 'freq', 0, 'exty', 0,'extfs', 0, 'location', 5j);
eventdata(2) = struct('type','cosine','delay',0.5,'duration',0.1,'amplitude',1, 'freq', 20, 'exty', 0,'extfs', 0, 'location', 2+8j);

E = eventgen_multi(eventdata, 1);
[Z, Pz] = transform_multi(eventdata, avsdata, E);
N = noisegen(Z, 100);
Pz = noisegen(Pz, 100);
[P, A] = avsreceiver_multi(N, Pz, avsdata);

subplot(2,1,1);
plot(real(A(:,1,1)));
hold on;
plot(imag(A(:,1,1)));
plot(P(:,1,1));
subplot(2,1,2);
plot(real(A(:,2,1)));
hold on;
plot(imag(A(:,2,1)));
plot(P(:,2,1));
legend('show')
