close all;
%load('matlab.mat')
load('antinoise.mat')

noiseref = Reference.Ref(1:96000,1);
tas = linspace(0, 2, 96000);
filtered = filter(antinoise, noiseref);

fftnoise = abs(fft(noiseref));
fftfilter = abs(fft(filtered));

fftnoise = fftnoise(1:end/2);
fftfilter = fftfilter(1:end/2);
fas = linspace(1, 24000, 48000);

suptitle('Noise Whitening')

subplot(121)
hold on;
plot(tas, noiseref);
plot(tas, filtered);
ylabel('amplitude')
xlabel('time (s)')
legend('unfiltered', 'filtered')
title('Time domain filtered vs unfiltered noise')


subplot(122)
hold on;
plot(fas, (fftnoise))
plot(fas, (fftfilter))
ylabel('amplitude')
xlabel('frequency (Hz)')
legend('unfiltered', 'filtered')
ylim([0 0.4])
title('Frequency domain filtered vs unfiltered noise')
