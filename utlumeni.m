fs = 32e3;
f = 440;
A = 9e-1;
dur = 200e-3;

time = (0 : dur*fs - 1) / fs;
fade = (0:dur * fs-1)/fs;

x = sin(2 * pi * f * time);

utlum = -3;

k = 10^(utlum/20);

ticho = zeros(1, fs/2);
zvuk = [x, ticho, k * x];

sound(zvuk, fs); 