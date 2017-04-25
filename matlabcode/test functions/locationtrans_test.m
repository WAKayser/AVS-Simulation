function locationtrans_test
%LOCATIONTRANS_TEST Test for the locationtransform
%   Detailed explanation goes here
s = eventgen(0.25,0.25,50,1);
[x, y] = locationtransform([500 2000], s);
subplot(3,1,1);
plot(s);
subplot(3,1,2);
plot(noisegen(x', 100));
ylim([-5 * 10^-4, 5*10^-4])
subplot(3,1,3);
plot(noisegen(y', 100));
ylim([-5 * 10^-4, 5*10^-4])

end

