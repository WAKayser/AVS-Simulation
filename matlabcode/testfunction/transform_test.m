function transform_test
%LOCATIONTRANS_TEST Test for the locationtransform
%   Detailed explanation goes here
e1 = eventgen(0.25,0.25,50,1,1);
e2 = eventgen(0.375,0.25,0,1,1);

Z1 = transform(500+2000j, e1);
Z2 = transform(2000+800j, e2);
Y = (noisegen(Z1 + Z2, 100));

subplot(2,1,1);
plot(e1);
hold on;
plot(e2);
subplot(2,1,2);
plot(real(Y));
hold on;
plot(imag(Y));
end

