[audio, fs1] = audioread("C:\Users\Já\Downloads\impulsni_odezva\shrek.wav");
[response, fs2] = audioread("C:\Users\Já\Downloads\impulsni_odezva\imp2.wav");


if fs1 ~= fs2
       error("Vzorkovací frekvence nesedí.");
end


audio = audio - mean(audio); %odeètení stejnosmìrné složky
response = response - mean(response);

y = conv(audio, response); %takes funcking ages in time domain!

y = 0.999 * y * max(abs(y)); %normalize signal

audiowrite("C:\Users\Já\Downloads\impulsni_odezva\shrek.wav",  y, fs1);

sound(y, fs1);