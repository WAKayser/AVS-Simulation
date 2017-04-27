function noisegen_test
%NOISEGEN_TEST Short test function for noisegen function
    % It displays all the noise it would add to a signal
    Z = zeros(100,2,2) +0j;
    N = noisegen(Z, 40);
    plot(N(:,1,1));
    hold on;
    plot(N(:,1,2));
    plot(N(:,2,1));
    plot(N(:,2,2));
end

