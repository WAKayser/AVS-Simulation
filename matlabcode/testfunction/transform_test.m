function transform_test
%LOCATIONTRANS_TEST Test for the locationtransform
%   Detailed explanation goes here
avsdata(:,:,1) = create_array(0, 50, 2, pi, 0);
avsdata(:,:,2) = create_array(5000, 50, 2, 0, pi);

eventdata(1) = struct('type','pulse','delay',0.25,'duration',0.1,'amplitude',1, 'freq', 0, 'location', 500+200j);
eventdata(2) = struct('type','cosine','delay',0.5,'duration',0.1,'amplitude',1, 'freq', 20, 'location', 2000+800j);

E = eventgen_multi(eventdata, 1);
Z = transform_multi(eventdata, avsdata, E);
N = noisegen(Z, 100);

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

