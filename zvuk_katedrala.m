[audio, fs1] = audioread("C:\Users\Já\Downloads\impulsni_odezva\shrek.wav");
[response, fs2] = audioread("C:\Users\Já\Downloads\impulsni_odezva\imp2.wav");


if fs1 ~= fs2
       error("Vzorkovací frekvence nesedí.");
end


audio = audio - mean(audio); %odeètení stejnosmìrné složky
response = response - mean(response);

longer = max(length(audio), length(response));
audio = [audio; zeros(longer-length(audio), 1)];
response = [response; zeros(longer-length(response), 1)];


tic
%y = conv(audio, response); %takes funcking ages in time domain!
y = real(ifft(fft(audio).*fft(response))); %takes like 200 times less time (34 ms instead of 7 s)
toc;
y = 0.999 * y * max(abs(y)); %normalize signal

audiowrite("C:\Users\Já\Downloads\impulsni_odezva\modified.wav",  y, fs1);

sound(y, fs1);