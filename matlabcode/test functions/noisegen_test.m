function noisegen_test
%NOISEGEN_TEST Short test function for noisegen function
    % It displays all the noise it would add to a signal
    Z = zeros(100,1) +0j;
    N = noisegen(Z, 40);
    plot(Z);
    hold on;
    plot(N);
end

