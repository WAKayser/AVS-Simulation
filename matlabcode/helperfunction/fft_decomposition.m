function [Y, fas, tas] = fft_decomposition(x, Fs, d, ms, enable)
%FFT_DECOMPOSITION Summary of this function goes here
%   Detailed explanation goes here
    %x = input signal to be analyzed
    %Fs = sample frequency
    %d = overlap coefficient
    %ms = length of segment

    subplot(311)
    hold off;
    plot(real(x));
    hold on;
    plot(imag(x));
    
    segment = floor(ms * 10^-3* Fs); %N of samples within segment
    segments = length(x) / segment; %number of segments
    overlappingsegments = floor(segments + (d-1)*(segments - 1)); %number of segments including shifted segments
    Super(segment, overlappingsegments) = 0; %Create matrix Super in correct dimensions.
    
    for k=1:(overlappingsegments) %Loop all shifted segments
        begin = floor((k-1)*segment/d)+1; %Begin of shifted segmnets
        Super(:,k) = x(begin : begin + segment - 1); %Fill each row of Super with the local segmnet
    end
    
    subplot(312)
    Y = fftshift(fft(Super),1); %Shift FFT output to be able to recreate plot in frequency domain
    fas = (-1/2 * Fs : Fs/segment : 1/2 * Fs); %Create frequency axis
    tas = (0: ms*10^-3 : (1/d)*(overlappingsegments-1)* ms * 10^-3); %Create time axis.
    
    if enable == 1
        imagesc(tas, fas, abs(Y)); %Plot result
        xlabel('time [S]');
        ylabel('Freqency [Hz]');
        ylim([0 Fs/(2)]);
        set(gca,'YDir','normal'); % Sometimes axis get flipped
    end
end

