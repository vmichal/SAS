close all
clear all
clc

[signal, fs] = audioread('C:\Users\vomi\Downloads\SAS_zvuky\fletna.wav');
duration = length(signal)/fs;
time = (0 : length(signal)-1)/fs;

subplot(3,1,1)
plot(time, signal);
xlabel("Èas (s)");
ylabel("Amplituda");
grid;

%sound(signal, fs);

subplot(3,1,2);
S = fft(signal) / length(signal);


%Z pohledu na amplitudové spektrum zjistíme, že základní frekvence bude
%121Hz a všechny další vyšší harmonické jsou násobek tohoto èísla. 
frequencies = (0: length(S)-1)/duration;
plot(frequencies, 20*log10(abs(S)));
xlim([0 4000])
xlabel("Frekvence (Hz)");
ylabel("Amplituda [dB]");

subplot(3,1,3);
plot(frequencies, angle(S));
xlabel("Frekvence (Hz)");
ylabel("Fáze");
