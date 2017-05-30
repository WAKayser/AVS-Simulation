function transform_test
%LOCATIONTRANS_TEST Test for the locationtransform
%   Detailed explanation goes here
avsdata(:,:,1) = create_array(0, 5, 2, pi, 0, 5);
avsdata(:,:,2) = create_array(5j, 5, 2, 0, pi, 5);

eventdata(1) = struct('type','pulse','delay',0.1,'duration',0.6,'amplitude',1, 'freq', 0, 'exty', 0,'extfs', 0, 'location', 5+2j, 'speed', -10);
eventdata(2) = struct('type','cosine','delay',0.3,'duration',0.9,'amplitude',1, 'freq', 20, 'exty', 0,'extfs', 0, 'location', 10, 'speed', 5j);

E = eventgen_multi(eventdata, 2);
[Z, Pz] = transform_multi(eventdata, avsdata, E);
N = noisegen(Z, 100);
Pn = noisegen(Pz, 100);

subplot(2,2,1);
plot(real(N(:,1,1)));
hold on;
plot(imag(N(:,1,1)));
subplot(2,2,2);
plot(real(N(:,1,2)));
hold on;
plot(imag(N(:,1,2)));
subplot(2,2,3);
plot(real(N(:,2,1)));
hold on;
plot(imag(N(:,2,1)));
subplot(2,2,4);
plot(real(N(:,2,2)));
hold on;
plot(imag(N(:,2,2)));
end

