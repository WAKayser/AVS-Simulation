function noisegen_test
%NOISEGEN_TEST Short test function for noisegen function
    % It displays all the noise it would add to a signal
    Z = zeros(48000,2,2) +0j;
    N = noisegen(Z, 40, 2);
    plot(abs(fft(N(:,1,1))));
    hold on;
    plot(abs(fft(N(:,1,2))));
    plot(abs(fft(N(:,2,1))));
    plot(abs(fft(N(:,2,2))));
end

