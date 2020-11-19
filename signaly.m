clear
close all

fs = 1000;
f = 50;
A = 1;
dur = 200e-3;

amplification = 20; %dB

time = (0:dur*fs - 1) / fs;

sine = zatlumeni(A * sin(2 * pi * f * time), amplification);
obdelnik = zatlumeni(A * square(2 * pi * f * time), amplification);
pila = zatlumeni(A * sawtooth(2 * pi * f * time), amplification);

ref_vykon = vykon(sin(2 * pi * f * time));

mean(sine.^2)

subplot(3,1,1);
stem(time, sine);
%naše reference pro dBFullScale je hodnota výkonu sinusovky s amplitudou 1
title(['Vykon ' num2str(vykon(sine)) ' (' num2str(10*log10(vykon(sine)/ref_vykon)) ' dBFS)']);


subplot(3,1,2)
stem(time, obdelnik);
title("Vykon " +num2str(vykon(obdelnik))+ ' (' +num2str(10*log10(vykon(obdelnik)/ref_vykon))+ ' dBFS)');

subplot(3,1,3)
stem(time, pila);
title("Vykon "+num2str(vykon(pila))+ ' (' +num2str(10*log10(vykon(pila)/ref_vykon)) +' dBFS)');

