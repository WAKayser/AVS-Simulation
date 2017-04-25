function eventgen_test
    subplot(2, 1, 1);
    plot(eventgen(0.25,0.25,100,1))
    subplot(2, 1, 2);
    plot(eventgen(0.5,0.25,0,1))
end

