fs = 1000;
f = 50;
A = 1;
dur = 200e-3;

time = (0:dur*fs - 1) / fs;

sine = sin(2 * pi * f * time);
obdelnik = square(2 * pi * f * time);
pila = sawtooth(2 * pi * f * time);


mean(sine.^2);

subplot(3,1,1);
stem(time, sine);
title(num2str(vykon(sine)));

subplot(3,1,2)
stem(time, obdelnik);
title(num2str(vykon(obdelnik)));

subplot(3,1,3)
stem(time, pila);
title(num2str(vykon(pila)));
