function locationtrans_test
%LOCATIONTRANS_TEST Test for the locationtransform
%   Detailed explanation goes here
e1 = eventgen(0.25,0.25,50,1);
e2 = eventgen(0.375,0.25,0,1);
[x1, y1] = locationtransform([500 2000], e1);
[x2, y2] = locationtransform([2000 800], e2);
subplot(3,1,1);
plot(e1);
hold on;
plot(e2);
subplot(3,1,2);
plot(noisegen((x1 + x2)', 100));
ylim([-7 * 10^-4, 7*10^-4])
subplot(3,1,3);
plot(noisegen((y1 + y2)', 100));
ylim([-7 * 10^-4, 7*10^-4])

end

