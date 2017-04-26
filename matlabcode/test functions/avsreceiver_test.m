function avsreceiver_test
%AVSRECEIVER_TEST Summary of this function goes here
%   Detailed explanation goes here

E1 = eventgen(0.25,0.25,50,1,1);
E2 = eventgen(0.375,0.25,0,1,1);

Z1 = locationtransform(500+2000j, E1);
Z2 = locationtransform(2000+800j, E2);
Y = (noisegen(Z1 + Z2, 100));

[pressure, A] = avsreceiver(Y, pi/5, 16, 0.5);

subplot(2,2,1);
plot(E1);
hold on;
plot(E2);
title('Events at their location')

subplot(2,2,2);
plot(real(Y));
hold on;
plot(imag(Y));
title('Noisy signal')

subplot(2,2,3);
plot(pressure);
title('Pressure data')

subplot(2,2,4);
plot(real(A));
hold on;
plot(imag(A));
title('Vector data')    

end

