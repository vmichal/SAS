
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

%Spektrum je soum�rn� podle fs/2 a je periodick� (diskr�tn� sv�t).

%sampling frquency is 100 Hz, so we can measure frequencies [0, 99],
% whilst only frequencies [0, 49] can be measured reliably, the rest of the
% spectrogram is bent as goes towards zero (as can be seen in the lectures).

%Za��n�me v nule. Pakli�e je na vstupu sign�l s N (==fs*dur) vzorky, fft
%n�m d�v� vektor rovn� s N prvky, proto�e m��e obsahovat v�echny frekvence [0, fs-1]
frequencies = (0:sample_count-1)/dur;

subplot(3,1,2);
stem(frequencies, abs(Y));
title("Modulus");

subplot(3,1,3);
stem(frequencies, angle(Y));
title("Phase");