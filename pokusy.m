
fs = 1000;
f = 100;
A = 1;
dur = 50e-3;

time = (0:dur*fs - 1) / fs;

sine = sin(2 * pi * f * time);

plot(time, sine)