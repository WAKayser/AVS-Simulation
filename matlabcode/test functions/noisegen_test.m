function noisegen_test
%NOISEGEN_TEST Short test function for noisegen function
    % It displays all the noise it would add to a signal
    z = zeros(100,2,3);
    n = noisegen(z, 40);
    for a = 1:2
        for b = 1:3
            subplot(3,2, (a) + 2*(b-1));
            plot(n(:,a,b));
            xlabel(['a: ' num2str(a) ' b:' num2str(b)])
        end
    end
end

