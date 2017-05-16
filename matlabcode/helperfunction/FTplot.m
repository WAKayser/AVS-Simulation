function [G,t,f] = FTplot(x,Srate,Sdiv,zero_pad,time)
%Time frequency plot
%Plot time frequency over max 1s at a given samplerate and amount of
%samples to declare time unit

Lx = length(x);

if nargin == 4
    xsize = [x,zeros(1,zero_pad-Lx)];
elseif nargin == 5
    xsize = [x,zeros(1,zero_pad*Srate-Lx)];
else
    xsize = x;
end;

Lxsize = length(xsize);

y = reshape(xsize,Lxsize/Sdiv,[]);
G = fft(y,100000);
t = linspace(0,Lxsize/Srate,Sdiv*Lxsize/Srate);
f = linspace(-Srate/2, Srate/2, Srate/Sdiv);
G = fftshift(G,1);

imagesc(t,f,abs(G))

end