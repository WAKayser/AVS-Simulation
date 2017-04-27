function detected = avsdspmodule(pressure, A, avsdata)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    [Y, fas, tas] = fft_decomposition(A, 16000, 1, 25, 1);
    treshold = 50 * abs(mean(mean(Y)))
    [row, col] = find((Y) > treshold);
    size(row)
    subplot(313)
    stem(tas(col), fas(row))
    xlim([0 1])
    for i = 1:size(row)
        y = Y(row(i), col(i))
        hoek = angle(y)
        t = tas(col(i))
        f = fas(row(i))
    end
end

    