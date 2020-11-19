
fs = 100;

f = 10;
A = 1;
dur = 5;

sample_count = fs * dur;
sampling_step = 1/fs;

time = (0 : sample_count-1) * sampling_step;
u = A * cos(2 * pi * time * f);

subplot(3, 1, 1);
stem(time, u);
title("Original signal")

%complex numbers with module and phase
Y = fft(u) / length(u); %normalize amplitudes (so that amplitudes are not function of the signal length).
%without normalization, the spectrum would contain amplitudes 50

%Spektrum je soumìrné podle fs/2 a je periodické (diskrétní svìt).

%sampling frquency is 100 Hz, so we can measure frequencies [0, 99],
% whilst only frequencies [0, 49] can be measured reliably, the rest of the
% spectrogram is bent as goes towards zero (as can be seen in the lectures).

%Zaèínáme v nule. Pakliže je na vstupu signál s N (==fs*dur) vzorky, fft
%nám dává vektor rovnìž s N prvky, protože mùže obsahovat všechny frekvence [0, fs-1]
frequencies = (0:sample_count-1)/dur;

subplot(3,1,2);
stem(frequencies, abs(Y));
title("Modulus");

subplot(3,1,3);
stem(frequencies, angle(Y));
title("Phase");