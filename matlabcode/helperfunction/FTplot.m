function [G,t,f] = FTplot(x,Srate,Sdiv,zero_pad,time)
%Time frequency plot
%Plot time frequency over max 1s at a given samplerate and amount of
%samples to declare time unit

    Lx = length(x);

    % Flexible setup for the ft plot
    % can be used to overlap windows
    if nargin == 4
        xsize = [x,zeros(1,zero_pad-Lx)];
    elseif nargin == 5
        xsize = [x,zeros(1,zero_pad*Srate-Lx)];
    else
        xsize = x;
    end;

    Lxsize = length(xsize);

    % Do the magic transforms
    y = reshape(xsize,Lxsize/Sdiv,[]);
    G = fftshitft(fft(y,100000), 1);

    % Create the axis
    t = linspace(0,Lxsize/Srate,Sdiv*Lxsize/Srate);
    f = linspace(-Srate/2, Srate/2, Srate/Sdiv);

    % Plot the picture
    imagesc(t,f,abs(G))

    %also returns the data, so it can be used for analysis.
end
