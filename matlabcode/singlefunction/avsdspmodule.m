function detected = avsdspmodule(pressure, A, avsdata)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    [Y, fas, tas] = fft_decomposition(A, 16000, 1, 25, 1);
    treshold = 100 * abs(mean(mean(Y)))
    [row, col] = find(abs(Y) > treshold);
    size(row)
    subplot(223);
    plot(abs(xcorr(A)))
    
    subplot(224)
    t = [];
    f = [];
    for i = 1:size(row, 1)
        if fas(row(i)) >= 0
            t = [t col(i)]
            f = [f row(i)]
        end
    end
    stem(tas(t), fas(f))
    xlim([0 1])
end

    