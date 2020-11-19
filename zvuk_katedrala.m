[audio, fs1] = audioread("C:\Users\J�\Downloads\impulsni_odezva\shrek.wav");
[response, fs2] = audioread("C:\Users\J�\Downloads\impulsni_odezva\imp2.wav");


if fs1 ~= fs2
       error("Vzorkovac� frekvence nesed�.");
end


audio = audio - mean(audio); %ode�ten� stejnosm�rn� slo�ky
response = response - mean(response);

y = conv(audio, response); %takes funcking ages in time domain!

y = 0.999 * y * max(abs(y)); %normalize signal

audiowrite("C:\Users\J�\Downloads\impulsni_odezva\shrek.wav",  y, fs1);

sound(y, fs1);